class Adddatetoplatform < ActiveRecord::Migration[5.0]
  def change
    add_column :platforms, :release_date, :date
  end
end
