class PostsController < ApplicationController
  before_action :set_post, except: [:index, :new, :create]
  before_action :set_vote, only: [:vote_delete]
  before_action :require_user, only: [:new, :create, :vote]
  before_action only: [:edit, :update, :destroy] do
    require_obj_owner(@post)
  end
  before_action only: [:vote_delete] do
    require_obj_owner(@vote)
  end
  
  def index
    @posts = Post.all.votes_then_recent
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
    @comments = @post.comments.votes_then_recent
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
    @vote = Vote.create(user_id: current_user.id, voteable: @post)
    
    if @vote.valid?
      redirect_to :back
    else
      flash['error'] = "Something went wrong, try to vote again"
      redirect_to :back
    end
  end
  
  def vote_delete
    @vote.destroy
    redirect_to :back
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
  
  def set_post
    @post = Post.find(params[:id])
  end
  
  def set_vote
    @vote = Vote.find_by(user_id: current_user.id, voteable: @post)
  end
end