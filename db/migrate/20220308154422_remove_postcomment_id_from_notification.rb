class RemovePostcommentIdFromNotification < ActiveRecord::Migration[5.2]
  def change
    remove_column :notifications, :post_comment_id, :integer
  end
end
