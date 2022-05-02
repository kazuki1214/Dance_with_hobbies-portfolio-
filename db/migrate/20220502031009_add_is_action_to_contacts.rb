class AddIsActionToContacts < ActiveRecord::Migration[5.2]
  def change
    add_column :contacts, :is_action, :boolean, default: false
  end
end
