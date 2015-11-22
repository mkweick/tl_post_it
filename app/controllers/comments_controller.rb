class CommentsController < ApplicationController
  before_action :set_post, except: [:index, :new, :show]
  before_action :set_comment, except: [:index, :new, :create, :show]
  before_action :set_vote, only: [:vote_delete]
  before_action :require_user, only: [:create, :vote]
  before_action only: [:edit, :update, :destroy] { require_creator(@comment) }
  before_action only: [:vote_delete] { require_creator(@vote) }

  def create
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user
    
    if @comment.save
      redirect_to post_path(@post)
    else
      @post.reload
      @comments = @post.comments.votes_then_recent
      render 'posts/show'
    end
  end
  
  def edit; end
  
  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      @post.reload
      render :edit
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end
  
  def vote
    @vote = Vote.create(creator: current_user, voteable: @comment)
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
  def vote_delete
    @vote.destroy
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end
  
  private
  
  def set_post
    @post = Post.find_by slug: params[:post_id]
  end
  
  def set_comment
    @comment = @post.comments.find(params[:id])
  end
  
  def set_vote
    @vote = Vote.find_by(creator: current_user, voteable: @comment)
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end