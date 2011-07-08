class CreateOrganizations < ActiveRecord::Migration
  def self.up
    create_table :organizations do |t|
      t.string :name
      t.string :street
      t.string :city
      t.string :zip
      t.string :phone
      t.boolean :active, :default => true

      t.timestamps
    end
  end

  def self.down
    drop_table :organizations
  end
end
