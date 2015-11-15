class CategoriesController < ApplicationController

  def show
    @category = Category.find_by(name: params[:id].capitalize)
    @posts = @category.posts.votes_then_recent
  end
end