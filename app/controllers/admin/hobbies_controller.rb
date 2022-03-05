class Admin::HobbiesController < ApplicationController

  def show
    @hobby = Hobby.find(params[:id])
  end

  def new
    @hobby = Hobby.new
  end

  def create
    @hobby = Hobby.new(hobby_params)
    @categories = params[:hobby][:category]
    if @hobby.save
      @categories.pluck(:id).each do |c|
        category_list = @hobby.hobby_categories.new
        category_list.category_id = Category.find(c)
        category_list.save
      end
    else
      render :new
    end
  end

  def edit
    @hobby = Hobby.find(params[:id])
    @categories = Category.all
  end

  def update
    @hobby = Hobby.find(params[:id])
    @hobby.hobby_categories.category_id = params[:hobby][:category]
    @hobby.update(hobby_params)
    redirect_to admin_hobby(@hobby)
  end

  def destroy
    Hobby.find(params[:id]).destroy
    redirect_to admin_root
  end

  private

  def hobby_params
    params.require(:hobby).permit(:title, :introduction, :hobby_image_id)
  end

  def category_names
    params[:hobby][:category_name]
  end

end
