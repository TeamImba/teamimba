class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new({:email => params[:email], :password => params[:password]})
    if request.xhr?
      if @user_session.save
        render :text => params[:email], :status => 200
      else
        render :nothing => true, :status => 500
      end
    else
      if @user_session.save
        flash[:notice] = "Login successful!"
        redirect_back_or_default admin_sites_url
      else
        render :action => :new
      end
    end
    #if @user_session.save
    #  render :text => params[:email], :status => 200
    #else
    #  render :nothing => true, :status => 500
    #end
  end
  
  def create_with_fb
    if fgraph_logged_in?
      me = FGraph.me(:access_token => fgraph_session_cookies["access_token"])
      existing_fb_user = User.find_by_facebook_id(me["id"])
      if existing_fb_user.nil?
        u = User.new
        u.facebook_id = me["id"]
        u.email = me["email"]
        u.password = "celine"
        u.password_confirmation = "celine"
        u.save(false)
      end
      create_user_session({:login => "#{me["email"]}", :password => "celine"})
    end
    if request.xhr?
      render :nothing => true, :status => 200
    else
      redirect_back_or_default root_url
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "Logout successful!"
    redirect_to root_url
  end
  
  private
  def create_user_session(data)
    @user_session = UserSession.new(data)
    @user_session.save do |result|
      if result
        current_user = @user_session.record
      else
        flash[:error] = "Login Failed"
      end
    end
  end
end
