class SessionsController < ApplicationController
  before_action :require_auth_session_var, only: [:pin]
  before_action :store_previous_url, only: [:new]
  
  def new
    redirect_to root_path if logged_in?
  end
  
  def create
    user = User.find_by(username: params[:username].downcase)
    
    if user && user.authenticate(params[:password])
      if user.two_factor
        user.generate_pin!
        user.send_pin_to_twilio
        set_auth_session_vars(user)
        redirect_to pin_path
      else
        login_user(user)
        redirect_to (session[:previous_url] || root_path)
      end
    else
      flash.now['error'] = "You have entered an invalid username or password"
      render :new
    end
  end
  
  def destroy
    if logged_in?
      session.delete(:user_id)
      flash['notice'] = "You have been logged out!"
      redirect_to root_path
    else
      redirect_to root_path
    end
  end
  
  def pin
    if request.post?
      user = User.find_by(username: session[:username])
      
      if user && user.pin == params[:pin]
        clear_auth_session_vars
        user.clear_user_pin!
        login_user(user)
        redirect_to (session[:previous_url] || root_path)
      else
        session[:pin_attempts_left] -= 1
        if session[:pin_attempts_left] > 0
          flash['error'] = "Incorrect pin. You have #{session[:pin_attempts_left]} 
                            #{'submission'.pluralize(session[:pin_attempts_left])}
                            left."
          redirect_to pin_path
        else
          clear_auth_session_vars
          user.clear_user_pin!
          flash['error'] = "For security purposes, your pin has been cleared to 
                            protect your account, please login again."
          redirect_to login_path
        end
      end
    end
  end
  
  private
  
  def store_previous_url
    session[:previous_url] = request.referer
  end
  
  def require_auth_session_var
    unless session[:username]
      redirect_to root_path
    end
  end
  
  def set_auth_session_vars(user)
    session[:username] = user.username
    session[:pin_attempts_left] = 3
  end
  
  def clear_auth_session_vars
    session.delete(:username)
    session.delete(:pin_attempts_left)
  end
end