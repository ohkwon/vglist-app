class ChangeToPlatformed < ActiveRecord::Migration[5.0]
  def change

    rename_column :deals, :game_id, :platformed_game_id

  end
end
