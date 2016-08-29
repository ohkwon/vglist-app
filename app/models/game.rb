# class Game < ApplicationRecord

#   has_many :user_games
#   has_many :users, through: :user_games

#   has_many :platformed_games
#   has_many :platforms, through: :platformed_games

#   has_many :genred_games
#   has_many :genres, through: :genred_games

#   has_many :user_genres
#   has_many :users, through: :user_genres
#   has_many :genres, through: :user_genres

#   def lowest_deals
#     platform_deals = []

#     self.platformed_games.each do |platformed_game|
#       if platformed_game.deals.where(active: true).any?
#         platform_deals << { platform_name: platformed_game.platform.name , price: platformed_game.deals.where(active: true).order(:price).first.price, platformed_game_id: platformed_game.id, deal_id: platformed_game.deals.where(active: true).order(:price).first.id }
#       end
#     end
    
#     return platform_deals

#   end
  
# end

class Game

  attr_accessor :id, :name, :slug, :created_at, :updated_at, :summary, :storyline, :genres, :release_dates

  def initialize(game)

    
    @id = game["id"]
    @name = game["name"]
    @slug = game["slug"]
    @created_at = game["created_at"]
    @updated_at = game["updated_at"]
    @summary = game["summary"]
    @storyline = game["storyline"]
    @genres = game["genres"]
    @release_dates = game["release_dates"]

  end

end