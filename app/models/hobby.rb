class Hobby < ApplicationRecord
  has_many :hobby_categories, dependent: :destroy
  has_many :categories, through: :hobby_categories
  has_many :posts, dependent: :destroy

  attachment :hobby_image

  #お気に入り機能メソッド
  def favorite_hobbies?(end_user)
    FavoriteHobby.where(end_user_id: end_user.id).exists?
  end

end
