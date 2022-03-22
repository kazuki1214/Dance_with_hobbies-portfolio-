class Post < ApplicationRecord
  is_impressionable

  # 中間テーブルを先に入力
  belongs_to :hobby
  belongs_to :end_user
  has_many :post_tags
  has_many :tags, through: :post_tags
  has_many :post_comments, dependent: :destroy
  has_many :favorite_posts, dependent: :destroy

  #通知機能
  has_many :notifications, dependent: :destroy

  attachment :post_image

  #検索機能
  def self.search(keyword)
    self.where(["title like ?", "%#{keyword}%"])
  end

  # いいね機能
  def favorite_posts?(end_user)
    favorite_posts.where(end_user_id: end_user.id).exists?
  end

  #タグ作成機能
  def save_tags(tags)
    #タグが存在していれば、タグの名前を配列として全て取得
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    #現在取得したタグから送られてきたタグを除いてold_tagとする
    old_tags = current_tags - tags

    new_tags = tags - current_tags

    #古いタグを
    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end

  end

  #いいね通知機能
  def create_notification_like!(current_end_user)
    #既にいいねされているか検索する
    temp = Notification.where(["visitor_id = ? and visited_id = ? and post_id = ? and action = ? ", current_end_user.id, end_user_id, id, 'like'])
    #いいねされていない場合のみ、通知レコード作成
    if temp.blank? #blank?はnilまたは空のオブジェクトを判定する
      notification = current_end_user.active_notifications.new(post_id: id, visited_id: end_user_id, action: 'like')

      #自分の投稿に対するいいねの場合は通知済にする
      if notification.visitor_id == notification.visited_id
        notification.checked = true
      end
      notification.save if notification.valid?
    end
  end

  #コメント通知機能
  def create_notification_comment!(current_end_user, post_comment_id)
    #自分以外にコメントしたユーザーIDを全て取得し、全員に通知を送る(重複は一つにまとめる[.distinct])
    temp_ids = PostComment.select(:end_user_id).where(post_id: id).where.not(end_user_id: current_end_user.id).distinct
    temp_ids.each do |temp_id|
      save_notification_comment!(current_end_user, post_comment_id, temp_id['end_user_id'])
    end
    #まだ誰もコメントしていない場合は投稿者に通知する
    save_notification_comment!(current_end_user, post_comment_id, end_user_id) if temp_ids.blank?
  end

  def save_notification_comment!(current_end_user, post_comment_id, visited_id)
    # コメントは複数回することが考えられるため、１つの投稿に複数回通知する
    notification = current_end_user.active_notifications.new(post_id: id, post_comment_id: post_comment_id, visited_id: visited_id, action: 'comment')
    if notification.visitor_id == notification.visited_id
      notification.checked = true
    end
    notification.save if notification.valid?
  end

end
