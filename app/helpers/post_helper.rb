module PostHelper
  
  def post_btn_text(post)
    post.new_record? ? 'Create Post' : 'Update Post'
  end
  
  def categories?(post)
    !post.categories.nil?
  end
  
  def format_date(post)
    post.created_at.to_date.to_formatted_s(:long).upcase
  end
end