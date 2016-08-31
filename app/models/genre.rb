class Genre

  attr_accessor :id, :name, :created_at, :updated_at, :slug, :url, :games

  def initialize(genre)

    @id = genre["id"]
    @name = genre["name"]
    @created_at = genre["created_at"]
    @updated_at = genre["updated_at"]
    @slug = genre["slug"]
    @url = genre["url"]
    @games = genre["games"]

  end

end

# class Genre < ApplicationRecord

#   has_many :genred_games
#   has_many :games, through: :genred_games

#   has_many :user_genres
#   has_many :games, through: :user_genres
#   has_many :users, through: :user_genres

# end
