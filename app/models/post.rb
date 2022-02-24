class Post < ApplicationRecord
  belongs_to :hobby
  belongs_to :end_user_id
  has_many :post_histories
  has_many :tags, through: :post_tags
  has_many :post_tags
end
