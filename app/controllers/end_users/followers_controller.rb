class EndUsers::FollowersController < ApplicationController

  def index
    @user = EndUser.find(params[:end_user_id])
    @followers = @user.followers.all
  end

  def create
    @user = EndUser.find(params[:end_user_id])
    current_end_user.follow(@user)
    redirect_to user_page(@user)
  end

  def destroy
    @user = current_end_user.followers.find(params[:id]).follower
    current_end_user.unfollow(@user)
    redirect_to user_page(@user)
  end

end
