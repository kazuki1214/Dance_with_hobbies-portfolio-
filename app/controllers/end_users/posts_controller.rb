class EndUsers::PostsController < ApplicationController

  def index
    @hobby = Hobby.find(params[:id])
    @posts = @hobby.posts.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.order('created_at: desc').limit(3)
  end

  def new
    @hobby = Hobby.find(params[:id])
    @post = @hobby.posts.new
  end

  def confirm
    @hobby = Hobby.find(params[:id])
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    @post.hobby_id = @hobby.id
    if tags = params[:post][:tags].split(',')
      @post.save_tags(tags)
    end
  end

  def create
    @hobby = Hobby.find(params[:id])
    @post = Post.new(post_params)
    @post.end_user_id = current_end_user.id
    @post.hobby_id = @hobby.id
    tags = params[:post][:tags].split(',')
    if @post.save
      @post.save_tags(tags)
      redirect_to hobby_post_path(@hobby.id,@post.id)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_back (fallback_loctaion :root_path)
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :title, :body)
  end

end
