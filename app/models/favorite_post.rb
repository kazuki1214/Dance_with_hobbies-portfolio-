class FavoritePost < ApplicationRecord
  belongs_to :end_user
  belongs_to :post

end
