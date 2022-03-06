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
  has_many :followers, dependent: :destroy
  has_many :followings, through: :followers, source: :follower
  has_many :passive_followers, class_name: 'Follower', foreign_key: 'follow_user_id', dependent: :destroy
  has_many :follow_users, through: :passive_followers, source: :end_user
  
  def favorite_hobbies?(end_user)
    FavoriteHobby.where(end_user_id: end_user.id).exists?
  end
  
  def favorite_posts?(end_user)
    FavoritePost.where(end_user_id: end_user.id).exists?
  end
  
  def following?(user)
    followings.include?(user)
  end

  def follow(user)
    if self == user
      followers.find_or_create_by!(follower: user)
    end
  end

  def unfollow(folllower_id)
    Follower.find(follower_id).destroy
  end

end
