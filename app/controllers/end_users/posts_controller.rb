class EndUsers::PostsController < ApplicationController
  impressionist :actions => [:show]

  def index
    @hobby = Hobby.find(params[:hobby_id])
    @posts = @hobby.posts.page(params[:page]).order(created_at: :desc)
  end

  def show
    @hobby = Hobby.find(params[:hobby_id])
    @post = Post.find(params[:id])
    @comments = @post.post_comments.order(created_at: :desc).limit(3)
    if @post.end_user != current_end_user
      impressionist(@post, nil, unique: [:session_hash.to_s])
    end
  end

  def new
    @hobby = Hobby.find(params[:hobby_id])
    @new_post = @hobby.posts.new
  end

  def confirm
    @hobby = Hobby.find(params[:hobby_id])
    @new_post = Post.new(post_params)
    @new_post.end_user = current_end_user
    @new_post.hobby_id = @hobby.id
    @tags = params[:post][:name]
  end

  def create
    @hobby = Hobby.find(params[:hobby_id])
    @post = Post.new(post_params)
    @post.end_user = current_end_user
    @post.hobby_id = @hobby.id
    tags = params[:post][:name].split(',').uniq
    if @post.save
      @post.save_tags(tags)
      @post.save_histories(@post)
      redirect_to hobby_post_path(@hobby.id,@post.id)
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to hobby_posts_path(params[:hobby_id])
  end

  def search
    
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :title, :body)
  end

end
