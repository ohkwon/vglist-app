class PlatformedGamesController < ApplicationController

  def new

  end

  def create

    platformed_game = PlatformedGame.new(
      game_id: params[:game_id],
      platform_id: params[:platform_id]
      )

  end

end
