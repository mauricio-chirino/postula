class AddFieldsToUsers < ActiveRecord::Migration[7.2]
  def change
    add_column :users, :name, :string
    add_column :users, :avatar, :string
    add_column :users, :is_admin, :boolean
  end
end
