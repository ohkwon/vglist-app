class User < ApplicationRecord

  has_secure_password

  has_many :user_games
  has_many :games, through: :user_games
  has_many :user_genres
  has_many :games, through: :user_genres
  has_many :genres, through: :user_genres

end
