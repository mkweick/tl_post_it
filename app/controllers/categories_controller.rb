class CategoriesController < ApplicationController
  before_action :set_category, only: [:show]
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    
    if @category.save
      redirect_to category_path(@category)
    else
      render :new
    end
  end
  
  def show
    @posts = @category.posts.order(:created_at).reverse
  end
  
  private
  
  def set_category
    @category = Category.find(params[:id])
  end
  
  def category_params
    params.require(:category).permit(:name)
  end
end