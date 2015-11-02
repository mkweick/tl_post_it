module CommentHelper
  
  def comment_body_text(comment)
    comment.new_record? ? 'Leave a comment:' : 'Update Comment'
  end
  
  def comment_btn_text(comment)
    comment.new_record? ? 'Create Comment' : 'Update Comment'
  end
end