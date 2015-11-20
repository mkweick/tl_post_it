module ApplicationHelper
  
  def nav_categories
    Category.all.alphabetize
  end
  
  def fix_external_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end
  
  def gravatar_for(user, options = { size: 40 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: "#{user.username}_Image", class: "gravatar")
  end
  
  def vote_post_or_comment(obj, comment)
    if comment
      vote_post_comment_path(obj.post, obj)
    else
      vote_post_path(obj)
    end
  end
  
  def vote_html_id(obj, comment)
    comment ? "comment-#{ obj.id }" : "post-#{ obj.slug }"
  end
end