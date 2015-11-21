class CategoriesController < ApplicationController

  def show
    @category = Category.find_by(name: params[:id].capitalize)
    @posts = @category.posts.votes_then_recent.offset(params[:offset]).limit(10)
    @pages = (@category.posts.all.size.to_f / 10).ceil
  end
end