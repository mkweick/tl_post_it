class CommentsController < ApplicationController
  before_action :set_post, only: [:create, :edit, :update, :destroy]
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :require_user, only: [:create, :vote]
  before_action only: [:edit, :update, :destroy] do
    require_obj_owner(@comment)
  end

  def create
    @comment = @post.comments.build(comment_params)
    @comment.creator = current_user
    
    if @comment.save
      redirect_to post_path(@post)
    else
      @post.reload
      @comments = @post.comments.recent
      render 'posts/show'
    end
  end
  
  def edit; end

  def update
    if @comment.update(comment_params)
      redirect_to post_path(@post)
    else
      render :edit
    end
  end
  
  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end
  
  def vote
    
  end
  
  private
  
  def set_post
    @post = Post.find(params[:post_id])
  end
  
  def set_comment
    @comment = @post.comments.find(params[:id])
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end