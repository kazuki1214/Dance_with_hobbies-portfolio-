class EndUsers::HobbiesController < ApplicationController

  def index
    @hobbies = Hobby.page(params[:page]).per(9)
  end

  def search
    @hobbies = Hobby.search(params[:keyword]).page(params[:page]).per(9)
    @keyword = params[:keyword]
    render :index
  end

  def show
    @hobby = Hobby.find(params[:id])
    @posts = @hobby.posts.order(created_at: :desc).limit(3)
  end
end
