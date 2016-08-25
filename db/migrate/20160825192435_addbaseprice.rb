class Addbaseprice < ActiveRecord::Migration[5.0]
  def change
    add_column :platformed_games, :base_price, :decimal, precision: 5, scale: 2
  end
end
