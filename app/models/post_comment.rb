class PostComment < ApplicationRecord
  belongs_to :post
  belongs_to :end_user

  #通知機能
  has_many :notifications, dependent: :destroy

  validates :comment, presence: true

end
