class Hobby < ApplicationRecord
  has_many :hobby_categories, dependent: :destroy
  has_many :hobbies, throurgh: :hobby_categories

  attachment :hobby_image
  
  def save_categroy(category_names)
    ActiveRecord::Base.transaction do
      self.hobby_categories = category_names.map{ |name| Category.find_by(name: name.strip) }
      save!
    end
  end
end
