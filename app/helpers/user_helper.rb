module UserHelper
  
  def user_btn_text(user)
    user.new_record? ? 'Create Profile' : 'Update Profile'
  end
  
  def format_date(user)
    user.created_at.to_date.to_formatted_s(:long)
  end
  
  def get_recent_post(user)
    link_to user.posts.recent.first.title, post_path(user.posts.recent.first),
                                                            class: 'latest-post'
  end
end