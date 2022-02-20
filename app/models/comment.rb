class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :end_user

end
