class CategoriesController < ApplicationController

  def show
    @category = Category.find_by(name: params[:id].capitalize)
    
    if params[:page].nil?
      @posts = @category.posts.votes_then_recent.limit(10)
    else
      @posts = @category.posts
                        .votes_then_recent
                        .offset((params[:page].to_i - 1) * 10)
                        .limit(10)
    end
    
    @pages = (@category.posts.all.size.to_f / 10).ceil
  end
end