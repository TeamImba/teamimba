class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new({:email => params[:email], :password => params[:password], :password_confirmation => params[:password]})
    if request.xhr?
      if @user.save
        render :text => params[:email], :status => 200
      else
        render :text  => @user.errors.full_messages.join("<br />"), :status => 500
      end
    else
      # should not be here...
      if @user.save
        redirect_to root_url
      else
        flash[:notice] = @user.errors.full_messages.join("<br />")
        redirect_to root_url
      end
    end
    
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end
end