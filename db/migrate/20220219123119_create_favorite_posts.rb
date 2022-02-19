class CreateFavoritePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_posts do |t|
      t.integer :end_user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
