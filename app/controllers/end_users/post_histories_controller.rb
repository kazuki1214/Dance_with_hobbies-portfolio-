class EndUsers::PostHistoriesController < ApplicationController
  def index
    @end_user = EndUser.find(params[:end_user_id])
    @posts = @end_user.post_histories.all
  end

  def show
    @end_user = EndUser.find(params[:end_user_id])
    @post = @end_user.posthistories.find(params[:id])
  end

  def destroy
    PostHistory.find(params[:id]).destroy
    redirect_to end_user_post_histories_path(current_end_user.id)
  end
end
