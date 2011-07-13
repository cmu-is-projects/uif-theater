class CreateRequestItems < ActiveRecord::Migration
  def self.up
    create_table :request_items do |t|
      t.integer :item_id
      t.integer :request_id
      t.integer :quantity_requested
      t.integer :quantity_approved
      t.datetime :date_checked_out

      t.timestamps
    end
  end

  def self.down
    drop_table :request_items
  end
end
