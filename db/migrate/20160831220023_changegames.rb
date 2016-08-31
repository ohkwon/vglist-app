class Changegames < ActiveRecord::Migration[5.0]
  def change
    rename_column :games, :idgb_created_at, :igdb_created_at
    rename_column :games, :idgb_updated_at, :igdb_updated_at
  end
end
