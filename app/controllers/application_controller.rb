class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def login_user(user)
    session[:user_id] = user.id
  end
  
  def require_user
    unless logged_in?
      flash[:error] = "Please log in or register for an account above!"
      redirect_to root_path
    end
  end
  
  def require_creator(obj)
    unless obj && logged_in? && (current_user == obj || current_user == obj.creator)
      flash[:error] = "Access Denied"
      redirect_to root_path
    end
  end
end