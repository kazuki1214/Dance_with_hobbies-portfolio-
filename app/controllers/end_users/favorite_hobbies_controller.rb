class EndUsers::FavoriteHobbiesController < ApplicationController

  def create
    favorite_hobby = Hobby.find(params[:hobby_id])
    favorite = current_end_user.favorite_hobbies.new(hobby_id: favorite_hobby.id)
    favorite.save
  end

  def destroy
    favorite_hobby = Hobby.find(params[:hobby_id])
    favorite = current_end_user.favorite_hobbies.new(hobby_id: favorite_hobby.id)
    favorite.destroy
  end

end
