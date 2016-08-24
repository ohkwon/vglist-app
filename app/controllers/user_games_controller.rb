class UserGamesController < ApplicationController

  before_action :authenticate_user!

  def index

    @user_games = current_user.user_games

  end

  def create

    game_id_list = []

    current_user.user_games.each do |user_game|
      game_id_list << user_game.game_id
    end

    if !game_id_list.include?(params[:game_id])

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

    else

      flash[:danger] = "Game is already on your list!"
      redirect_to '/user_games'      
      
    end

  end

  def update

    user_game = UserGame.find_by(id: params[:id])
    user_game.assign_attributes(
      ownership: !user_game.ownership
      )
    if user_game.save
      flash[:success] = "#{Game.find_by(id: user_game.game_id).name} ownership status changed on your list!"
      redirect_to '/user_games'
    else
      flash[:danger] = "Error!"
      redirect_to '/user_games'
    end
  end

  def destroy

    user_game = UserGame.find_by(id: params[:id])
    user_game.destroy
    flash[:success] = "Game removed from list"
    redirect_to "/user_games"

  end

end
