class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :user_image

  has_many :posts, through: :post_histories
  has_many :favorite_posts
  has_many :post_comments
  has_many :post_histories
  has_many :favorite_hobbies, through: :hobbies

  # フォロー機能
  has_many :followers, dependent: :destroy #自分が持つフォローユーザー
  has_many :followings, through: :followers, source: :follower　#followerモデルはfollowersモデルを参照
  has_many :passive_followers, class_name: 'Follower', foreign_key: 'follow_user_id', dependent: :destroy #その他のユーザーからおフォロー設定
  has_many :follow_users, through: :passive_followers, source: :end_user

  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy #自分からの送信
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy #相手からの送信

  #お気に入り機能メソッド
  def favorite_hobbies?(end_user)
    FavoriteHobby.where(end_user_id: end_user.id).exists?
  end

  def favorite_posts?(end_user)
    FavoritePost.where(end_user_id: end_user.id).exists?
  end

  #フォロー機能メソッド
  def following?(user)　#フォローの確認メソッド
    followings.include?(user)
  end

  def follow(user) #フォロー作成メソッド
    if self == user
      followers.find_or_create_by!(follower: user)
    end
  end

  def unfollow(folllower_id) #フォロー削除メソッド
    Follower.find(follower_id).destroy
  end

  #通知機能メソッド
  def unchecked_notifications
    current_end_user.passive_notifications.where(checked: false)
  end
end
