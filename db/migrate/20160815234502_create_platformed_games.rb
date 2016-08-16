class CreatePlatformedGames < ActiveRecord::Migration[5.0]
  def change
    create_table :platformed_games do |t|
      t.integer :game_id
      t.integer :platform_id
      t.date :release_date

      t.timestamps
    end
  end
end
