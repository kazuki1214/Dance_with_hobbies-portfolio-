class EndUsers::FavoritePostsController < ApplicationController

  def create
    favorite_post = Post.find(params[:hobby_id])
    favorite = current_end_user.favorite_posts.new(post_id: favorite_post.id)
    favorite.save
  end

  def destroy
    favorite_post = Post.find(params[:hobby_id])
    favorite = current_end_user.favorite_posts.new(post_id: favorite_post.id)
    favorite.destroy
  end

end
