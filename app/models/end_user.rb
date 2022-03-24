class EndUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  attachment :user_image

  has_many :posts
  has_many :favorite_posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :favorite_hobbies

  # フォロー機能
  has_many :followers, dependent: :destroy #自分が持つフォローユーザー
  # followingsでフォローしているユーザーを取得
  has_many :followings, through: :followers, source: :follow_user #follow_userモデルはfollowersモデルを参照

  has_many :passive_followers, class_name: 'Follower', foreign_key: 'follow_user_id', dependent: :destroy #その他のユーザーからのフォロー設定
  has_many :follow_users, through: :passive_followers, source: :end_user

  # 通知機能
  has_many :active_notifications, class_name: 'Notification', foreign_key: 'visitor_id', dependent: :destroy #自分からの送信
  has_many :passive_notifications, class_name: 'Notification', foreign_key: 'visited_id', dependent: :destroy #相手からの送信

  validates :name, presence: true

  #フォロー機能メソッド
  def following?(end_user) #フォローの確認メソッド
    followings.include?(end_user)
  end

  def follow(end_user) #フォロー作成メソッド
    return if self == end_user
    followers.find_or_create_by!(follow_user: end_user)
  end

  def unfollow(follower_id) #フォロー削除メソッド
    followers.find(follower_id).destroy!
  end

end
