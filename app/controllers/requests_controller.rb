class RequestsController < ApplicationController
  # GET /requests
  # GET /requests.xml
  def index
    if current_user.is_partner?
      @requests = Request.requests.chronological.all
    else
      @requests = Request.chronological.page(params[:page]).per(10)
      @pending_requests = Request.pending.chronological.all
    end
    

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @requests }
    end
  end

  # GET /requests/1
  # GET /requests/1.xml
  def show
    @request = Request.find(params[:id])
    @items = @request.items

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @request }
    end
  end

  # GET /requests/new
  # GET /requests/new.xml
  def new
    @request = Request.new
    @items = session[:item_ids]
    @request.requestor_id = current_user.id
    if current_user.is_partner?
      @request.status = 'pending'
    else
      @request.status = 'approved'
    end 

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @request }
    end
  end

  # GET /requests/1/edit
  def edit
    @request = Request.find(params[:id])
    if !@request.items.empty?
      @items = @request.items.map{|i| i.id}
      session[:item_ids] = @items
    else
      @items = session[:item_ids]
    end
    @request.approver_id = current_user.id

  end

  # POST /requests
  # POST /requests.xml
  def create
    @request = Request.new(params[:request])
    @request.requestor_id = current_user.id if params[:request][:requestor_id].nil?
    @request.status = 'pending' if current_user.is_partner?
    @request.date_processed = Time.now if @request.status == 'approved'
    @request.approver_id = current_user.id if @request.status == 'approved'

    respond_to do |format|
      if @request.save
        session[:item_ids].each do |item_id|
          ri = RequestItem.new
          ri.request_id = @request.id
          ri.item_id = item_id
          ri.date_checked_out = Time.now
          ri.save!
        end
        
        format.html { redirect_to(@request, :notice => 'Your request was successfully recorded.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  # PUT /requests/1
  # PUT /requests/1.xml
  def update
    @request = Request.find(params[:id])
    @request.approver_id = current_user.id
    @request.date_processed = Time.now

    respond_to do |format|
      if @request.update_attributes(params[:request])
        # Have to save any changes to request items
        @prior_items = @request.items.map{|i| i.id}
        @current_items = session[:item_ids]
        removed = @prior_items - @current_items
        added = @current_items - @prior_items
        
        # remove ones that are deleted
        removed.each do |item_id|
          ri = RequestItem.find_by_item_id_and_request_id(item_id, @request.id)
          ri.destroy
        end
        
        # add any new ones
        added.each do |item_id|
          ri = RequestItem.new
          ri.request_id = @request.id
          ri.item_id = item_id
          ri.date_checked_out = Time.now
          ri.save!
        end
        
        format.html { redirect_to(@request, :notice => 'Request was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /requests/1
  # DELETE /requests/1.xml
  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to(requests_url) }
      format.xml  { head :ok }
    end
  end
end
