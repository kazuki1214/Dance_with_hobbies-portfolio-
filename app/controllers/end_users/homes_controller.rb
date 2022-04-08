class EndUsers::HomesController < ApplicationController

  def top
    @ranking_hobbies = Hobby.ranking(3)
    @ranking_posts = Post.ranking(3)
  end

end
