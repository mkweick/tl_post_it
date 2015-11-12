class CategoriesController < ApplicationController

  def show
    @category = Category.find(params[:id])
    @posts = @category.posts.votes_then_recent
  end
end