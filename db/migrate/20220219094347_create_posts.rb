class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.integer :hobby_id
      t.integer :end_user_id
      t.string :post_image_id, null: true
      t.string :title
      t.text :body

      t.timestamps
    end
  end
end
