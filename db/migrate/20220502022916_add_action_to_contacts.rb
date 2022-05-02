class AddActionToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :action, :string, default: "対応未"
  end
end
