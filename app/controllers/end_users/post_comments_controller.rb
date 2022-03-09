class EndUsers::PostCommentsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @comment = @post.post_comments.all
    @hobby = @post.hobby
    @new_comment = @post.comments.new
  end

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_end_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.save
    @post_comment.create_notification_comment!(current_end_user, @post_comment.post_comment.id)
    redirect_to hobby_post_post_comments_path(params[:post_id])
  end

  def destroy
    PostComment.find(params[:id]).destroy
    redirect_to hobby_post_post_comments_path(params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
