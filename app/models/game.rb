class Game < ApplicationRecord

  has_many :user_games
  has_many :users, through: :user_games

  has_many :platformed_games
  has_many :platforms, through: :platformed_games
  
end
