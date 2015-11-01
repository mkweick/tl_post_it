module CategoryHelper
  
  def category_title(category)
    link_to('All Posts', posts_path, class: 'nav_link') + 
                                " &raquo; #{category.name}".html_safe
  end
end