class CreateCommentReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :comment_replies do |t|
      t.integer :comment_id
      t.integer :reply_id

      t.timestamps
    end
  end
end
