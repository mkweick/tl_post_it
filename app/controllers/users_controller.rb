class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action only: [:edit, :update] { require_creator(@user) }
  
  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      login_user(@user)
      flash['notice'] = "Welcome to Postit #{@user.username}! Create your 
                        first post by clicking New Post above!"
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
    @posts = @user.posts.votes_then_recent
    @comments = @user.comments.votes_then_recent
  end
  
  def edit; end
  
  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation,
                                  :email, :time_zone, :phone, :two_factor)
  end
  
  def set_user
    @user = User.find_by(username: params[:id])
  end
end