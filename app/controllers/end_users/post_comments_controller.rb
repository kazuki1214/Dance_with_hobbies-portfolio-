class EndUsers::PostCommentsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.all
    @hobby = @post.hobby
    @new_comment = @post.comments.new
  end

  def create
    @new_post = Post.find(params[:post_id]).new(comment_params)
    @new_post.end_user = current_end_user
    @new_post.save
    redirect_to hobby_post_post_comments_path(params[:post_id])
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to hobby_post_post_comments_path(params[:post_id])
  end

  private

  def comment_params
    params.require(:post_comment).permit(:comment)
  end

end
