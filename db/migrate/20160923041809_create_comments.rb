class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :game_id
      t.string :user_name
      t.text :text

      t.timestamps
    end
  end
end
