class EndUsers::HobbiesController < ApplicationController

  def index
    @hobbies = Hobby.page(params[:page]).per(9)
  end

  def search
    hobbies = Hobby.all.order(created_at: :desc)
    @keyword = params[:keyword]
    if @keyword.present?
      hobby_ids = []
      @keyword.split(/[[:blank:]]+/).each do |keyword|
        next if keyword == ""
        # 趣味モデルの検索
        hobby_ids += Hobby.search(keyword).pluck(:id)
      end
      # post_idsに全ての検索結果idを入れてflattenメソッドで二次元配列を一次元にする
      hobby_ids = hobby_ids.flatten
      hobbies = hobbies.where(id: hobby_ids).uniq
    end
    @hobbies = Kaminari.paginate_array(hobbies).page(params[:page]).per(9)
    render :index
  end

  def show
    @hobby = Hobby.find(params[:id])
    @posts = @hobby.posts.order(created_at: :desc).limit(3)
  end
end
