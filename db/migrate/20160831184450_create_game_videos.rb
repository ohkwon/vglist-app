class CreateGameVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :game_videos do |t|
      t.integer :game_id
      t.string :name
      t.string :video_id

      t.timestamps
    end
  end
end
