class CreateHobbies < ActiveRecord::Migration[5.2]
  def change
    create_table :hobbies do |t|
      t.string :title
      t.string :introduction
      t.string :hobby_image_id

      t.timestamps
    end
  end
end
