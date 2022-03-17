class EndUsers::FollowersController < ApplicationController

  def index
    @user = EndUser.find(params[:end_user])
    @followers = @user.followers.all
  end

  def create
    @user = EndUser.find(params[:follow_user])
    current_end_user.follow(@user)
  end

  def destroy
    @user = current_end_user.followers.find(params[:id]).follow_user
    current_end_user.unfollow(params[:id])
  end

end
