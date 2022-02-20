class FavoriteHobby < ApplicationRecord
  belongs_to :hobby
  belongs_to :end_user

end
