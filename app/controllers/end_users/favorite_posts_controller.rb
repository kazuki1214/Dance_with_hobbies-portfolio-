class EndUsers::FavoritePostsController < ApplicationController
  before_action :authenticate_end_user!

  def create
    @post = Post.find(params[:post_id])
    @favorite = current_end_user.favorite_posts.new(post_id: @post.id)
    @favorite.save
    @post.create_notification_like!(current_end_user)
  end

  def destroy
    @post = Post.find(params[:post_id])
    @favorite = current_end_user.favorite_posts.find_by(post_id: @post.id)
    @favorite.destroy
  end

end
