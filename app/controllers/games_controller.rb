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
      name: params[:name],
      description: params[:description]
      )

    if game.save
      flash[:success] = "Game Created!"
      redirect_to '/games'
    else
      flash[:danger] = "Error!"
      redirect_to '/games/new'
    end

  end

  def edit

    @game = Game.find_by(id: params[:id])

  end

  def update

    game = Game.find_by(id: params[:id])
    game.assign_attributes(
      name: params[:name],
      description: params[:description]
      )

    if game.save
      flash[:success] = "Game Updated!"
      redirect_to "/games/#{game.id}"
    else
      flash[:danger] = "Error!"
      redirect_to "/games/#{game.id}/edit"
    end
    
  end

end
