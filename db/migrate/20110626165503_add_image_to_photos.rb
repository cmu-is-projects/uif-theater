class AddImageToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :image, :string
    remove_column :photos, :photo_path
  end

  def self.down
    remove_column :photos, :image
    add_column :photos, :photo_path, :string
  end
end
