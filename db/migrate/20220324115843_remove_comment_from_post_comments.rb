class RemoveCommentFromPostComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :post_comments, :comment, :string
  end
end
