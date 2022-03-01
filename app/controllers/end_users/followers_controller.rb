class EndUsers::FollowersController < ApplicationController

  def index
    @followers = current_end_user.followers.all
  end

  def create
    user = EndUser.find(params[:end_user_id])
    follower = current_end_user.followers.new(follow_user_id: user.id)
    follower.save
    redirect_to user_page(user)
  end

  def destroy
    user = EndUser.find(params[:end_user_id])
    follower = current_end_user.followers.new(follow_user_id: user.id)
    follower.destroy
    redirect_to user_page(user)
  end

end
