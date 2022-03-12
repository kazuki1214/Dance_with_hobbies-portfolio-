class Category < ApplicationRecord
  has_many :hobby_categories, dependent: :destroy
  has_many :hobbies, through: :hobby_categories

  attachment :category_image

end
