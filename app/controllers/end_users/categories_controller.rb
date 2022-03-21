class EndUsers::CategoriesController < ApplicationController
  def index
    @categories = Category.page(params[:page]).per(3)
  end

  def search
    @categories = Category.search.page(params[:page]).per(3)
    @keyword = params[:keyword]
    render :index
  end

end
