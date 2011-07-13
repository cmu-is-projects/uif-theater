class CreateRequests < ActiveRecord::Migration
  def self.up
    create_table :requests do |t|
      t.integer :requestor_id
      t.string :production
      t.string :status
      t.datetime :date_processed
      t.integer :approver_id
      t.date :date_needed_by

      t.timestamps
    end
  end

  def self.down
    drop_table :requests
  end
end
