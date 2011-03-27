class CreateLists < ActiveRecord::Migration
  def self.up
    create_table :lists do |t|
      t.string :alias
      t.integer :latest_price_cents
      t.string :latest_price_currency
      t.string :unit
      t.string :participating_manufacturer
      t.integer :quantity
      t.string :url
      t.integer :user_id
      t.timestamps
    end
    add_index :lists, :user_id
  end

  def self.down
    drop_table :lists
  end
end
