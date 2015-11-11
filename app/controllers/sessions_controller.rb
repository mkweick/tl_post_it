class SessionsController < ApplicationController

  def new
    redirect_to root_path if logged_in?
  end
  
  def create
    user = User.find_by(username: params[:username])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash['error'] = nil
      redirect_to root_path
    else
      flash['error'] = "You have entered an invalid username or password"
      render :new
    end
  end
  
  def destroy
    if logged_in?
      session[:user_id] = nil
      flash['notice'] = "You have been logged out!"
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
end