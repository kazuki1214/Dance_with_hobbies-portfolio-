class Admin::CategoriesController < ApplicationController

  def index
    @categories = Category.page(params[:page]).per(5)
    @new_category = Category.new
  end

  def create
    @category = Category.new(category_params)
    @category.save
    redirect_to admin_categories_path
  end

  def destroy
    Category.find(params[:id]).destroy
    redirect_to admin_categories_path
  end

  private

  def category_params
    params.require(:category).permit(:name, :category_image)
  end

end
