class Addurltodeals < ActiveRecord::Migration[5.0]
  def change
    add_column :deals, :url, :string
  end
end
