class PostHistory < ApplicationRecord
  is_impressionable

  belongs_to :end_user
  belongs_to :post

end
