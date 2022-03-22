class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

    #検索機能
  def self.search(keyword)
    self.where(["name like?", "%#{keyword}%"])
  end

end
