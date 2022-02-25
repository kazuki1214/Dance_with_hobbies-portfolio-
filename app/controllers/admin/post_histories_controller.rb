class Admin::PostHistoriesController < ApplicationController
  def index
    @user = EndUser.find(params[:id])
  end

  def show
    @post = Post.find(params[:id])
    comments = @post.comments.includes(:end_user).order(created_at: :desc)
    @comments_first = comments.first(3)
    @comments_offset = comments.offset(3)
  end

  def destroy
    @post = Posthistrory.find(params[:id]).destroy
  end
end
