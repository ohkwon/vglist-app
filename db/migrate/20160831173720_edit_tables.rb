class EditTables < ActiveRecord::Migration[5.0]
  def change

    #Game Model
    add_column :games, :slug, :string
    add_column :games, :idgb_created_at, :time
    add_column :games, :idgb_updated_at, :time
    rename_column :games, :description, :summary
    add_column :games, :storyline, :text

    #Genre Model
    add_column :genres, :slug, :string

    #Platform Model
    add_column :platforms, :slug, :string

    #Platformed Game Model
    # change_column :platformed_games, :release_date, :time


  end
end
