class UserGenre < ApplicationRecord

  belongs_to :game
  belongs_to :genre
  belongs_to :user

end
