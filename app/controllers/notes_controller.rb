class NotesController < ApplicationController
  # GET /notes
  # GET /notes.xml
  def index
    @notable = find_notable
    @notes = @notable.notes
    
    case @notable.class.to_s
    when "User"
      @note_on = @notable.name
    when "Organization"
      @note_on = @notable.name
    when "Item"
      @note_on = @notable.name
    else
      @note_on = "FRED!"
    end


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @notes }
    end
  end

  # GET /notes/1
  # GET /notes/1.xml
  def show
    @note = Note.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/new
  # GET /notes/new.xml
  def new
    @note = Note.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @note }
    end
  end

  # GET /notes/1/edit
  def edit
    @note = Note.find(params[:id])
  end

  # POST /notes
  # POST /notes.xml
  def create
    @notable = find_notable
    @note = @notable.notes.build(params[:note])
    if @note.save
      note_type = @note.notable_type.downcase
      flash[:notice] = "Note added to #{note_type}."
      if note_type == "user"
        note_on = note_type
      else
        note_on = note_type.pluralize
      end
      id = @note.notable_id
      redirect_to :controller => note_on, :action => 'show', :id => id
    else
      render :action => 'new'
    end
  end

  # PUT /notes/1
  # PUT /notes/1.xml
  def update
    @note = Note.find(params[:id])

    respond_to do |format|
      if @note.update_attributes(params[:note])
        format.html { redirect_to(@note, :notice => 'Note was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @note.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1
  # DELETE /notes/1.xml
  def destroy
    @notable = find_notable
    @note = Note.find(params[:id])
    @note.destroy
    flash[:notice] = "Note has been deleted."
    if @note.notable_type == "User"
      note_on = @note.notable_type.downcase
    else
      note_on = @note.notable_type.pluralize.downcase
    end
    id = @note.notable_id
    redirect_to :controller => note_on, :action => 'show', :id => id
  end
  
  private
  def find_notable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end
end
