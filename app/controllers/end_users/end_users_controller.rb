class EndUsers::EndUsersController < ApplicationController

  def show
    @user = EndUser.find(params[:id])
    @hobbies = Hobby.where(id: @user.favorite_hobbies.pluck(:hobby_id)).all
  end

  def edit
    @user = current_end_user
  end

  def update
    @user = current_end_user
    if @user.update(user_params)
      redirect_to user_page_path(@user)
    else
      render :edit
    end
  end

  def withdraw
    user = current_end_user
    user.update(is_deleted: true)
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:end_user).permit(:name, :user_comment, :user_image )
  end

end
