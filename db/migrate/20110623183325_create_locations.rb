class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string :storage_type
      t.string :storage_unit
      t.integer :container

      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
