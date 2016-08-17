class GenredGamesController < ApplicationController

  def new

  end

  def create

    genred_game = GenredGame.new(
      game_id: params[:game_id],
      genre_id: params[:genre][:genre_id]
      )
    
    if genred_game.save
      flash[:success] = "Genre added to game!"
      redirect_to "/games/#{params[:game_id]}"
    else
      flash[:danger] = "Error!"
      redirect_to "/genred_game/new"
    end

  end

end
