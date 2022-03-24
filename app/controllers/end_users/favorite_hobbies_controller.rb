class EndUsers::FavoriteHobbiesController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @hobby = Hobby.find(params[:hobby_id])
    @favorite = current_end_user.favorite_hobbies.new(hobby_id: @hobby.id)
    @favorite.save
  end

  def destroy
    @hobby = Hobby.find(params[:hobby_id])
    @favorite = current_end_user.favorite_hobbies.find_by(hobby_id: @hobby.id)
    @favorite.destroy
  end

end
