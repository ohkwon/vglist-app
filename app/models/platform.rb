# class Platform < ApplicationRecord

#   has_many :platformed_games
#   has_many :games, through: :platformed_games

# end

class Platform

  attr_accessor :id, :name, :logo, :slug, :url, :created_at, :updated_at, :url, :games, :versions

  def initialize(platform)

    @id = platform["id"]
    @name = platform["name"]
    @logo = platform["logo"]
    @slug = platform["slug"]
    @url = platform["url"]
    @created_at = platform["created_at"]
    @updated_at = platform["updated_at"]
    @url = platform["url"]
    @games = platform["games"]
    @versions = platform["versions"]

  end

end