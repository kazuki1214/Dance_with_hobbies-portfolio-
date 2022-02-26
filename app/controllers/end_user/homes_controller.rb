class EndUser::HomesController < ApplicationController

  def top
    @ranking_hobbies = Hobby.find(FavoriteHobby.group(:hobby_id).order('count(hobby_id) desc').limit(3).pluck(:hobby_id))
    @ranking_posts = Post.find(FavoritePost.group(:post_id).order('count(post_id) desc').limit(3).pluck(:post_id))
  end

end
