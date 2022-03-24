class EndUsers::PostsController < ApplicationController
  impressionist :actions => [:show]

  def index
    @hobby = Hobby.find(params[:hobby_id])
    @posts = @hobby.posts.page(params[:page]).order(created_at: :desc)
  end

  def search
    @hobby = Hobby.find(params[:hobby_id])
    @keyword = params[:keyword]
    posts = @hobby.posts.order(created_at: :desc)

    if @keyword.present?
      post_ids = []
      @keyword.split(/[[:blank:]]+/).each do |keyword|
        next if keyword == ""
        # 投稿モデルの検索
        post_ids += @hobby.posts.search(keyword).pluck(:id)
        # タグモデルの検索
        tag_ids = Tag.search(keyword).pluck(:id)
        if tag_ids.present?
          tag_ids.each do |tag_id|
            tag_post_ids = Tag.find(tag_id).posts.pluck(:id)
            post_ids += @hobby.posts.where(id: tag_post_ids)
          end
        end
      end
      # post_idsに全ての検索結果idを入れてflattenメソッドで二次元配列を一次元にする
      post_ids = post_ids.flatten
      posts = posts.where(id: post_ids).uniq
    end
    @posts = Kaminari.paginate_array(posts).page(params[:page])
    render :index
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
    if @new_post.invalid?
      render :new
    end
  end

  def create
    @hobby = Hobby.find(params[:hobby_id])
    @post = Post.new(post_params)
    @post.end_user = current_end_user
    @post.hobby_id = @hobby.id
    tags = params[:post][:name].split(',').uniq
    if @post.save
      @post.save_tags(tags)
      flash[:notice] = "投稿に成功しました"
      redirect_to hobby_post_path(@hobby.id,@post.id)
    else
      render :new
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:destroy] = "投稿を削除しました"
    redirect_to hobby_posts_path(params[:hobby_id])
  end

  private

  def post_params
    params.require(:post).permit(:post_image, :title, :body)
  end

end
