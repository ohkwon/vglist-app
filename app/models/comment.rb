class Comment < ApplicationRecord

  belongs_to :game
  has_many :replies, class_name: "Comment", foreign_key: "reply_id"
  belongs_to :original_comment, class_name: "Comment"

end
