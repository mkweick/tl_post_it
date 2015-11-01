class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update]
  
  def index
    @posts = Post.all.sort_by(&:created_at).reverse
  end
  
  def new
    @post = Post.new
  end
  
  def create
    @post = Post.new(post_params)
    @post.creator = User.first # Fix after authentication
    
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end
  
  def show
    @comment = Comment.new
    @comments = @post.comments.sort_by(&:created_at).reverse
  end
  
  def edit; end
  
  def update
    if @post.update_attributes(post_params)
      redirect_to post_path
    else
      render :edit
    end
  end
  
  private
  
  def set_post
    @post = Post.find(params[:id])
  end
    
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
end