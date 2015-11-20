class SessionsController < ApplicationController
  before_action :require_auth, only: [:pin]
  
  def new
    redirect_to root_path if logged_in?
  end
  
  def create
    user = User.find_by(username: params[:username].downcase)
    
    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        user.generate_pin!
        user.send_pin_to_twilio
        session[:username] = user.username
        session[:pin_attempts_left] = 5
        redirect_to pin_path
      else
        session[:user_id] = user.id
        redirect_to root_path
      end
    else
      flash.now['error'] = "You have entered an invalid username or password"
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
  
  def pin
    if request.post?
      user = User.find_by(username: session[:username])
      
      if user && user.pin == params[:pin]
        session[:pin_attempts_left] = nil
        session[:username] = nil
        user.update_column(:pin, nil)
        session[:user_id] = user.id
        redirect_to root_path
      else
        session[:pin_attempts_left] -= 1
        if session[:pin_attempts_left] > 0
          flash['error'] = "You've entered an incorrect pin, you have #{session[:pin_attempts_left]} 
                            #{'submission'.pluralize(session[:pin_attempts_left])}
                            left"
          redirect_to pin_path
        else
          session[:pin_attempts_left] = nil
          user.update_column(:pin, nil)
          flash['error'] = "You entered the wrong pin 5 times. Your pin has been 
                          cleared to protect your profile, login again."
          redirect_to login_path
        end
      end
    end
  end
  
  private
  
  def require_auth
    unless session[:username]
      redirect_to root_path
    end
  end
end