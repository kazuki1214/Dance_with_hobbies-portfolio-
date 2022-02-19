class CreatePostHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :post_histories do |t|
      t.integer :end_user_id
      t.integer :post_id

      t.timestamps
    end
  end
end
