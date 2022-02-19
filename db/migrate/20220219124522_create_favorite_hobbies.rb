class CreateFavoriteHobbies < ActiveRecord::Migration[5.2]
  def change
    create_table :favorite_hobbies do |t|
      t.integer :end_user_id
      t.integer :hobby_id

      t.timestamps
    end
  end
end
