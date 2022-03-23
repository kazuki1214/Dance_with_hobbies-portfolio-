class Admin::EndUsersController < ApplicationController
  def index
    @users = EndUser.page(params[:page])
  end

  def show
    @user = EndUser.find(params[:id])
  end

  def edit
    @user = EndUser.find(params[:id])
  end

  def update
    @user = EndUser.find(params[:id])
    @user.update(user_params)
    redirect_to admin_end_users_path
  end

  private

  def user_params
    params.require(:end_user).permit(:email, :is_deleted)
  end

end
