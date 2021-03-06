class EndUsers::PostHistoriesController < ApplicationController
  before_action :authenticate_end_user!, only:[:destroy]
  before_action :destroy_params, only:[:destroy]
  impressionist :actions => [:show]

  def index
    @end_user = EndUser.find(params[:end_user_id])
    @posts = @end_user.posts.page(params[:page]).order(created_at: :desc)
  end

  def search
    @end_user = EndUser.find(params[:end_user_id])
    @keyword = params[:keyword]
    posts =  @end_user.posts.order(created_at: :desc)

    if @keyword.present?
      post_ids = []
      @keyword.split(/[[:blank:]]+/).each do |keyword|
        next if keyword == ""
        # 投稿モデルの検索
        post_ids += @end_user.posts.search(keyword).pluck(:id)
        # 趣味モデルの検索(完全一致)
        hobby = Hobby.find_by(title: keyword)
        if hobby.present?
          hobby_posts_ids = hobby.posts.pluck(:id)
          post_ids += @end_user.posts.where(id: hobby_posts_ids)
        end
        # タグモデルの検索
        tag_ids = Tag.search(keyword).pluck(:id)
        if tag_ids.present?
          tag_ids.each do |tag_id|
            tag_post_ids = Tag.find(tag_id).posts.pluck(:id)
            post_ids += @end_user.posts.where(id: tag_post_ids)
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
    @end_user = EndUser.find(params[:end_user_id])
    @post = @end_user.posts.find(params[:id])
    @comments = @post.post_comments.order(created_at: :desc)
    if @post.end_user != current_end_user
      impressionist(@post, nil, unique: [:session_hash.to_s])
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    flash[:destroy] = "投稿を削除しました"
    redirect_to end_user_post_histories_path(current_end_user.id)
  end

  private

  def destroy_params
    post = Post.find(params[:id])
    if post.end_user != current_end_user
      redirect_to end_user_post_history_path(post)
    end
  end

end
