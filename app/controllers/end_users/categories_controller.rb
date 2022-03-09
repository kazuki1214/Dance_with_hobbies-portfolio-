class EndUsers::CategoriesController < ApplicationController
  def index
    @categories = Category.page(params[:page]).per(3)
  end
end
