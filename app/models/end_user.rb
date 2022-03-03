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
  has_many :followers
  has_many :favorite_hobbies

  def find_by?(user)
    Follower.where(end_user: end_user.id).exists?
  end

end
