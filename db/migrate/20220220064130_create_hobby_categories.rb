class CreateHobbyCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :hobby_categories do |t|
      t.integer :hobby_id
      t.integer :category_id

      t.timestamps
    end
  end
end
