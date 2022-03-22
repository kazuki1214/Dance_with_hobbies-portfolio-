class EndUsers::CategoriesController < ApplicationController
  def index
    @categories = Category.page(params[:page]).per(3)
  end

  def search

    @keyword = params[:keyword]
    if @keyword
      @categories = []
      @keyword.split(/[[:blank:]]+/).each do |keyword|
        next if keyword == ""
        @categories += Category.search(@keyword)
      end
      @categories.uniq!
    end
    @categories = @categories.page(params[:page]).per(3)
    render :index
  end

end
