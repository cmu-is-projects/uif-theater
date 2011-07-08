class CreateItemCategories < ActiveRecord::Migration
  def self.up
    create_table :item_categories do |t|
      t.integer :item_id
      t.integer :category_id

      t.timestamps
    end
  end

  def self.down
    drop_table :item_categories
  end
end
