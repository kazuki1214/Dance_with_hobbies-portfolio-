class Admin::HobbiesController < ApplicationController
  before_action :authenticate_admin!

  def show
    @hobby = Hobby.find(params[:id])
  end

  def new
    @hobby = Hobby.new
  end

  def create
    @hobby = Hobby.new(hobby_params)
    if @hobby.save
      params[:hobby][:category_ids].each do |category|
        hobby_category = HobbyCategory.new
        hobby_category.hobby_id = @hobby.id
        hobby_category.category_id = category
        hobby_category.save
      end
      redirect_to admin_hobby_path(@hobby)
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
    if @hobby.update(hobby_params)
      if params[:hobby][:category_ids] == nil
        old_category = HobbyCategory.where(hobby_id: @hobby.id)
        old_category.each do |c|
          c.destroy
        end

      elsif params[:hobby][:category_ids]
        old_category = HobbyCategory.where(hobby_id: @hobby.id)
        old_category.each do |c|
          c.destroy
        end
        params[:hobby][:category_ids].each do |category|
          hobby_category = HobbyCategory.new
          hobby_category.hobby_id = @hobby.id
          hobby_category.category_id = category
          hobby_category.save
         end
      end
      redirect_to admin_hobby_path(@hobby)
    else
      render :edit
    end
  end

  def destroy
    Hobby.find(params[:id]).destroy
    redirect_to admin_root_path
  end

  private

  def hobby_params
    params.require(:hobby).permit(:title, :introduction, :hobby_image)
  end

end
