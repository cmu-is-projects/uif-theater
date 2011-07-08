class AddMoreToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :status, :integer
    add_column :users, :phone, :string
  end

  def self.down
    remove_column :users, :phone
    remove_column :users, :status
  end
end