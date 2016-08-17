class Addactivetodeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :active, :boolean
  end
end
