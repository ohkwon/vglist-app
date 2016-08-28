class Genre < ApplicationRecord

  has_many :genred_games
  has_many :games, through: :genred_games

  has_many :user_genres
  has_many :games, through: :user_genres
  has_many :users, through: :user_genres

end
