class GamesController < ApplicationController

  def index

    @games = Game.all

  end

  def show

    @game = Game.find_by(id: params[:id])

  end

  def new

  end

  def create

    game = Game.new(
      name: params[:name]
      )

    if game.save
      flash[:success] = "Game Created!"
      redirect_to '/games'
    else
      flash[:danger] = "Error!"
      redirect_to '/games/new'
    end

  end

end
