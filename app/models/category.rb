class Category < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :hobbies, through: :post_tags

end
