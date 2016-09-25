class Comment < ApplicationRecord

  belongs_to :game
  has_many :replies, class_name: "Comment", foreign_key: "reply_id"
  belongs_to :original_comment, class_name: "Comment", foreign_key: "reply_id", optional: true

  belongs_to :user

  # validates_exclusion_of :reply_id, allow_blank: true
  # validates :name, presence: false, allow_nil: true

end
