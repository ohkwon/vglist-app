class Game < ApplicationRecord

  has_many :user_games
  has_many :users, through: :user_games

  has_many :platformed_games
  has_many :platforms, through: :platformed_games

  has_many :genred_games
  has_many :genres, through: :genred_games

  def lowest_deals
    platform_deals = []

    platformed_games.each do |platformed_game|
      platform_deals = << { platform_name: platformed_game.platform.name , price: platformed_game.deals.where(active: true).order(:price).first
    end
    #edited lowest_deals model method. have not yet fixed all relevant view pages

  end
  
end
