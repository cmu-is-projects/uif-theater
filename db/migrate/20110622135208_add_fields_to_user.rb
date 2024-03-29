class AddFieldsToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :organization_id, :integer
    add_column :users, :role, :string
  end

  def self.down
    remove_column :users, :role
    remove_column :users, :organization_id
    remove_column :users, :last_name
    remove_column :users, :first_name
  end
end