class Platform < ApplicationRecord

  has_many :platformed_games
  has_many :games, through: :platformed_games

end
