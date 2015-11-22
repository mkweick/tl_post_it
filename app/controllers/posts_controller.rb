class PostsController < ApplicationController
  before_action :set_post, except: [:index, :new, :create]
  before_action :set_vote, only: [:vote_delete]
  before_action :require_user, only: [:new, :create, :vote]
  before_action only: [:edit, :update, :destroy] { require_creator(@post) }
  before_action only: [:vote_delete] { require_creator(@vote) }
  
  def index
    if params[:page].nil?
      @posts = Post.all.votes_then_recent.limit(10)
    else
      @posts = Post.all.votes_then_recent.offset((params[:page].to_i - 1) * 10).limit(10)
    end
    
    @pages = (Post.all.size.to_f / 10).ceil
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
    
    respond_to do |format|
      format.html
      format.json { render json: @post }
    end
  end
  
  def edit; end
  
  def update
    if @post.update(post_params)
      redirect_to post_path(@post)
    else
      @post.reload
      render :edit
    end
  end
  
  def destroy
    @post.destroy
    redirect_to posts_path
  end
  
  def vote
    @vote = Vote.create(creator: current_user, voteable: @post)
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
  def vote_delete
    if @vote
      @vote.destroy
      
      respond_to do |format|
        format.html { redirect_to :back }
        format.js
      end
    else
      
    end
  end
  
  private
  
  def post_params
    params.require(:post).permit(:title, :url, :description, category_ids: [])
  end
  
  def set_post
     @post = Post.find_by slug: params[:id]
  end
  
  def set_vote
    @vote = Vote.find_by(creator: current_user, voteable: @post)
  end
end