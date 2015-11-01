module PostHelper
  
  def new_post?(post)
    post.new_record?
  end
  
  def post_type(post)
    new_post?(post) ? 'Create Post' : 'Update Post'
  end
  
  def cancel_btn_if_edit(post)
    link_to 'Cancel', post_path(post), class: 'btn' if !new_post?(post)
  end
  
  def categories?(post)
    !post.categories.nil?
  end
  
  def format_date(post)
    post.created_at.to_date.to_formatted_s(:long).upcase
  end
end