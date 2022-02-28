class EndUser::EndUsersController < ApplicationController

  def show
    @user = EndUser.find(params[:id])
  end

  def edit
    @user = current_end_user
  end

  def update
    user = current_end_user
    user.update(user_params)
    redirect_to end_user_path(user)
  end

  def withdraw
    user = current_end_user
    user.update(is_deleted: true)
    redirect_to root_path
  end

  private

  def user_params
    params.require(:end_user).permit(:name, :email, :user_commet, :user_image )
  end

end
