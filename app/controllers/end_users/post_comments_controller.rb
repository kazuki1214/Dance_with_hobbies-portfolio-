class EndUsers::PostCommentsController < ApplicationController

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.post_comments.all
    @hobby = @post.hobby
    @new_comment = PostComment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @post_comment = current_end_user.post_comments.new(post_comment_params)
    @post_comment.post_id = @post.id
    @post_comment.save
    @post.create_notification_comment!(current_end_user, @post_comment.id)
    redirect_to hobby_post_post_comments_path(params[:post_id])
  end

  def destroy
    comment = PostComment.find_by(id: params[:id])
    comment.destroy

    redirect_to hobby_post_post_comments_path(params[:hobby_id], params[:post_id])
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
