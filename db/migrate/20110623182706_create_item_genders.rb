class CreateItemGenders < ActiveRecord::Migration
  def self.up
    create_table :item_genders do |t|
      t.integer :item_id
      t.integer :gender_id

      t.timestamps
    end
  end

  def self.down
    drop_table :item_genders
  end
end
