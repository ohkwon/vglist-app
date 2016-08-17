class CreateDeals < ActiveRecord::Migration[5.0]
  def change
    create_table :deals do |t|
      t.integer :game_id
      t.string :retailer
      t.decimal :price, precision: 6, scale: 2
      t.date :date

      t.timestamps
    end
  end
end
