class UserController < ApplicationController
  
  def index
    @users = User.alphabetical.page(params[:page]).per(10)
    @pending_users = User.pending.alphabetical.all
  end


  def show
    @user = User.find(params[:id])
    @notes = @user.notes
    @notable = @user
  end


  def new
    @user = User.new
  end


  def edit
    @user = User.find(params[:id])
  end



  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(home_path, :notice => 'User was successfully created.') }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to(home_path, :notice => 'User was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
    @user = User.find(params[:id])
    @user.status = -1
    @user.update_attribute(:status, -1)
    # @user.destroy

    respond_to do |format|
      format.html { redirect_to(user_index_path, :notice => "#{@user.name} was deactivated.") }
      format.xml  { head :ok }
    end
  end
  
  def approve_user
    @user = User.find(params[:id])
    @user.status = 1
    @user.update_attribute(:status, 1)
    respond_to do |format|
      format.html { redirect_to(user_index_path, :notice => "#{@user.name} was approved.") }
    end
  end
  
  def reject_user
    @user = User.find(params[:id])
    @user.status = -1
    @user.update_attribute(:status, -1)
    respond_to do |format|
      format.html { redirect_to(user_index_path, :alert => "#{@user.name} was rejected.") }
    end
  end
end
