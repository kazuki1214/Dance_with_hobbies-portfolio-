class Hobby < ApplicationRecord
  has_many :hobby_categories, dependent: :destroy
  has_many :categories, through: :hobby_categories
  has_many :posts, dependent: :destroy
  has_many :favorite_hobbies, dependent: :destroy

  attachment :hobby_image

  validates :title, presence: true
  validates :hobby_image, presence: true

  #検索機能
  def self.search(keyword)
    self.where(["title like?", "%#{keyword}%"])
  end

  #お気に入り機能メソッド
  def favorite_hobbies?(end_user)
    favorite_hobbies.where(end_user_id: end_user.id).exists?
  end

end
