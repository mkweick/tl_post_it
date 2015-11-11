class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_owner, only: [:edit, :update]
  
  def new
    redirect_to root_path if logged_in?
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      session[:user_id] = @user.id
      flash['notice'] = "Welcome to Postit #{@user.first_name}! Create your 
                        first post by clicking New Post above!"
      redirect_to root_path
    else
      render :new
    end
  end
  
  def show
    @posts = @user.posts.recent
    @comments = @user.comments.recent
  end
  
  def edit
    
  end
  
  def update
    if @user.update(user_params)
      redirect_to user_path
    else
      render :edit
    end
  end
  
  private
  
  def user_params
    params.require(:user).permit(:username, :password, :first_name, 
                                  :last_name, :email)
  end
  
  def set_user
    @user = User.find(params[:id])
  end
  
  def require_owner
    if logged_in?
      unless current_user == @user
        flash['error'] = "You can only edit your own profile"
        redirect_to root_path
      end
    else
      flash['error'] = "You must be logged in to do that"
      redirect_to root_path
    end
  end
end