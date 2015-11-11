module ApplicationHelper
  
  def nav_categories
    Category.all.sort_by(&:name)
  end
  
  def fix_external_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end
  
  def author_name(post)
    "#{post.creator.first_name} #{post.creator.last_name}"
  end
  
  def author_name_caps(post)
    "#{post.creator.first_name.upcase} #{post.creator.last_name.upcase}"
  end
  
  def gravatar_for(user, options = { size: 40 })
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    size = options[:size]
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
    image_tag(gravatar_url, alt: "#{user.first_name}_#{user.last_name}_Image", 
                                                              class: "gravatar")
  end
end