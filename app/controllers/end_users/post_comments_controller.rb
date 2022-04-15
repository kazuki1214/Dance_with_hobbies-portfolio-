class EndUsers::PostCommentsController < ApplicationController
  before_action :authenticate_end_user!, except:[:index]

  def index
    @post = Post.find(params[:post_id])
    @comments = @post.post_comments.all.order(created_at: :desc)
    @hobby = @post.hobby
    @new_comment = PostComment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @hobby = @post.hobby
    @new_comment = current_end_user.post_comments.new(post_comment_params)
    @new_comment.post_id = @post.id
    if @new_comment.save
      @post.create_notification_comment!(current_end_user, @new_comment.id)
      @hobby = @post.hobby
      @comments = @post.post_comments.all.order(created_at: :desc)
      @new_comment = PostComment.new
      render :create
    else
      render :errors
    end
  end

  def destroy
    @comment = PostComment.find_by(id: params[:id])
    if @comment.end_user == current_end_user
      if @comment.destroy
        @post = Post.find(params[:post_id])
        @hobby = @post.hobby
        @comments = @post.post_comments.all.order(created_at: :desc)
        @new_comment = PostComment.new
        render :create
      end
    end
  end

  private

  def post_comment_params
    params.require(:post_comment).permit(:comment)
  end

end
