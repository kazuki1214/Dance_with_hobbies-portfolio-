class Admin::HobbiesController < ApplicationController

  def show
    @hobby = Hobby.find(params[:id])
  end

  def new
    @hobby = Hobby.new
    @categories = Category.all
  end

  def create
    @hobby = Hobby.new(hobby_params)
    if @hobby.save_categroy(category_names)
      @hobby.save
      redirect_to admin_hobby(@hobby)
    else
      render :new
    end
  end

  def edit
    @hobby = Hobby.find(params[:id])
  end

  def update
    @hobby = Hobby.find(params[:id])
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
