class CategoriesController < ApplicationController

  def show
    @category = Category.find_by(name: params[:id].capitalize)
    @posts = @category.posts.votes_then_recent.offset((params[:page].to_i - 1) * 10).limit(10)
    @pages = (@category.posts.all.size.to_f / 10).ceil
  end
end