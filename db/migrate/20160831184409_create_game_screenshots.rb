class CreateGameScreenshots < ActiveRecord::Migration[5.0]
  def change
    create_table :game_screenshots do |t|
      t.integer :game_id
      t.string :cloudinary_id
      t.integer :width
      t.integer :height

      t.timestamps
    end
  end
end
