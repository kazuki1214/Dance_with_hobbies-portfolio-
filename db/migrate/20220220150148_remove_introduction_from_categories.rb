class RemoveIntroductionFromCategories < ActiveRecord::Migration[5.2]
  def change
    remove_column :categories, :introduction, :string
  end
end
