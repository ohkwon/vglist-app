class ChangeComment < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :reply_id, :integer
  end
end
