class CreatePhotos < ActiveRecord::Migration
  def self.up
    create_table :photos do |t|
      t.integer :item_id
      t.string :photo_path

      t.timestamps
    end
  end

  def self.down
    drop_table :photos
  end
end
