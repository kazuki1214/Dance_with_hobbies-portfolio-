class Follower < ApplicationRecord
  belongs_to :end_user
  belongs_to :follow_user, class_name: "EndUser"
end
