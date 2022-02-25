class EndUser::HomesController < ApplicationController

  def top
    @ranks_hobby = Hobby.find(FavoriteHobby.group(:hobby_id).order('count(hobby_id) desc').limit(3).pluck(:hobby_id))
  end

end
