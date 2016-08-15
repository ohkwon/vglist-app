class UserGamesController < ApplicationController

  def index

    @user_games = current_user.user_games

  end

  def create

    user_game = UserGame.new(
      game_id: params[:game_id],
      user_id: current_user.id
      )
    if user_game.save
      flash[:success] = "#{Game.find_by(id: params[:game_id]).name} added to your list!"
      redirect_to '/user_games'
    else
      flash[:danger] = "Error"
      redirect_to "games/#{params[:game_id]}"
    end

  end

end
