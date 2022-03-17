class EndUsers::PostHistoriesController < ApplicationController
  impressionist :actions => [:show]

  def index
    @end_user = EndUser.find(params[:end_user_id])
    @posts = Post.where(id: @end_user.post_histories.pluck(:post_id)).page(params[:page]).order(created_at: :desc)
  end

  def show
    @end_user = EndUser.find(params[:end_user_id])
    @post = Post.find(id: @end_user.post_histories.find(params[:id]).post_id)
    if @post.end_user != current_end_user
      impressionist(@post, nil, unique: [:session_hash.to_s])
    end
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to end_user_post_histories_path(current_end_user.id)
  end
end
