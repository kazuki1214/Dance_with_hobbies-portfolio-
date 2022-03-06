class Follower < ApplicationRecord
  belongs_to :follower, class_name: "EndUser"
  belongs_to :end_user
end
