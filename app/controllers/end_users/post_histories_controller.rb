class EndUsers::PostHistoriesController < ApplicationController
  impressionist :actions => [:show]

  def index
    @end_user = EndUser.find(params[:end_user_id])
    @posts = @end_user.post_histories.all
  end

  def show
    @end_user = EndUser.find(params[:end_user_id])
    @post = @end_user.posthistories.find(params[:id])
    if @post.end_user != current_end_user
      impressionist(@post, nil, unique: [:session_hash.to_s])
    end
  end

  def destroy
    PostHistory.find(params[:id]).destroy
    redirect_to end_user_post_histories_path(current_end_user.id)
  end
end
