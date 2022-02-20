class Hobby < ApplicationRecord
  has_many :hobby_categories, dependent: :destroy
  has_many :hobbies, throurgh: :hobby_categories

  attachment :hobby_image

end
