module ApplicationHelper
  
  def nav_categories
    Category.all.sort_by(&:name)
  end
  
  def fix_external_url(url)
    url.starts_with?('http://') ? url : "http://#{url}"
  end
end