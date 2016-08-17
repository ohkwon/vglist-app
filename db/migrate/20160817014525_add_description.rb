class AddDescription < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :description, :text
  end
end
