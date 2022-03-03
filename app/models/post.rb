class Post < ApplicationRecord
  belongs_to :hobby
  belongs_to :end_user_id
  has_many :post_histories, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :post_tags
  has_many :post_comments, dependent: :destroy

  attachment :post_image

  def save_tags(tags)
    current_tags = self.tags.pluck(:name) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    old_tags.each do |old|
      self.tags.delete Tag.find_by(name: old)
    end

    new_tags.each do |new|
      new_post_tag = Tag.find_or_create_by(name: new)
      self.tags << new_post_tag
    end

  end

end
