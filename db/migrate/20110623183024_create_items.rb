class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items do |t|
      t.string :name
      t.text :description
      t.string :keywords
      t.string :status
      t.string :size
      t.integer :quantity
      t.integer :location_id

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
