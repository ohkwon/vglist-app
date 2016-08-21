class PlatformedGamesController < ApplicationController

  before_action :authenticate_admin!

  def new

  end

  def create

    if params[:release_date] == ""
      release_date = ""
    else
      date_input = params[:release_date].split("-")
      release_date = Date.new(date_input[0].to_i, date_input[1].to_i ,date_input[2].to_i)
    end

    platformed_game = PlatformedGame.new(
      game_id: params[:game][:game_id],
      platform_id: params[:platform][:platform_id],
      release_date: release_date
      )

    if platformed_game.save
      flash[:success] = "Added platform to Game!"
      redirect_to '/games'
    else
      flash[:danger] = "Error!"
      redirect_to '/platformed_games/new'
    end

  end

end
