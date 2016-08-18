class Game < ApplicationRecord

  has_many :user_games
  has_many :users, through: :user_games

  has_many :platformed_games
  has_many :platforms, through: :platformed_games

  has_many :genred_games
  has_many :genres, through: :genred_games

  has_many :deals

  def lowest_deal
    deals.where(active: true).order(:price).first
  end
  
end
