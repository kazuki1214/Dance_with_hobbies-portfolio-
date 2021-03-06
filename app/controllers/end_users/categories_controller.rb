class EndUsers::CategoriesController < ApplicationController
  def index
    @categories = Category.page(params[:page]).per(3).includes(:hobbies)
  end

  def search
    categories = Category.all.order(created_at: :desc)
    @keyword = params[:keyword]
    if @keyword.present?
      category_ids = []
      @keyword.split(/[[:blank:]]+/).each do |keyword|
        next if keyword == ""
        category_ids += Category.search(keyword)
        hobby = Hobby.find_by(title: keyword)
        if hobby.present?
          hobby_categories = hobby.categories.pluck(:id)
          category_ids += Category.where(id: hobby_categories)
        end
      end
      category_ids = category_ids.flatten
      categories = categories.where(id: category_ids).uniq
    end
    @categories =  Kaminari.paginate_array(categories).page(params[:page]).per(3)
    render :index
  end

end
