class RemoveActionFromContacts < ActiveRecord::Migration[5.2]
  def change
    remove_column :contacts, :action, :string
  end
end
