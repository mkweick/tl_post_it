class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :require_user, only: [:new, :create, :vote]
  before_action only: [:edit, :update, :destroy] do
    require_obj_owner(@post)
  end
  
  def index
    @posts = Post.all.recent
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.creator = current_user
    
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def show
    @comment = Comment.new
    @comments = @post.comments.recent
  end
  
  def edit; end
  
  def update
    if @post.update(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path
  end
  
  def vote
    
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
end