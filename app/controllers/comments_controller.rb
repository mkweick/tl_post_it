class CommentsController < ApplicationController
  
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    # Alternative to above line:
      # @comment = Comment.new(comment_params)
      # @comment.post = @post
    @comment.creator = User.first #Fix after authentication
    
    if @comment.save
      redirect_to post_path(@post)
    else
      # @post.reload needed if using .build, in memory new comment gets 
      # added to @post.comments collection even though not saved to db yet
      @post.reload
      render 'posts/show'
    end
  end 
  
  private
  
  def comment_params
    params.require(:comment).permit(:body)
  end
  
end