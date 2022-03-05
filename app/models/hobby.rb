class Hobby < ApplicationRecord
  has_many :hobby_categories, dependent: :destroy
  has_many :categories, through: :hobby_categories
  has_many :posts, dependent: :destroy


  attachment :hobby_image

  def save_categories(tags)
    current_tags = self.categories.pluck(:name)
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # 古いカテゴリを削除
    old_tags.each do |old_name|
      self.categories.delete Category.find_by(name　:old_name)
    end

    # 新しくカテゴリ追加
    new_tags.each do |new_name|
      article_category = Category.find_by(name　:new_name)
      self.categories << article_category #自己演算子(ハッシュが追加されていく感じ）
    end
  end

  def save_categroy(category_names)
    ActiveRecord::Base.transaction do
      self.hobby_categories = category_names.map{ |name| Category.find_by(name: name.strip) }
      save!
    end
  end
end
