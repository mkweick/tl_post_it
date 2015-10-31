class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comment_params)
    @comment.post = @post
    # Alternative to above 2 lines:
      # @comment = @post.comments.build(comment_params)
      # can't use time_ago_in_words on the view becasue show post view
      # has both index and new actions for comments on it
    @comment.creator = User.first #Fix after authentication
    
    if @comment.save
      redirect_to post_path(@post)
    else
      render 'posts/show'
    end
  end 
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end