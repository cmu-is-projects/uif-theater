class CreateItemColors < ActiveRecord::Migration
  def self.up
    create_table :item_colors do |t|
      t.integer :item_id
      t.integer :color_id

      t.timestamps
    end
  end

  def self.down
    drop_table :item_colors
  end
end
