class Admin::EndUsersController < ApplicationController
  before_action :authenticate_admin!

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
    if @user.update(user_params)
      redirect_to admin_end_users_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:end_user).permit(:email, :is_deleted)
  end

end
