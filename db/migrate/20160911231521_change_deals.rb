class ChangeDeals < ActiveRecord::Migration[5.0]
  def change
    rename_column :deals, :platformed_game_id, :game_id
  end
end
