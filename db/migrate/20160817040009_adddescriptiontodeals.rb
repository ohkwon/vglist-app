class Adddescriptiontodeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :description, :text
  end
end
