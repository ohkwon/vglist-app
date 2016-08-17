class Genre < ApplicationRecord

  has_many :genred_games
  has_many :games, through: :genred_games

end
