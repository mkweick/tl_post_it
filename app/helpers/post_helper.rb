module PostHelper
  
  def post_btn_text(post)
    post.new_record? ? 'Create Post' : 'Update Post'
  end
  
  def set_correct_tz(dt)
    logged_in? ? dt.in_time_zone(current_user.time_zone) : dt
  end
  
  def display_date(dt)
    dt.strftime("%^b %d, %Y %l:%M%P #{ '%Z' unless logged_in?}")
  end
end