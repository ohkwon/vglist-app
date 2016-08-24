class GamesController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]

  def index

    sort_attribute = params[:sort_attribute]
    sort_attribute_2 = params[:sort_attribute_2]
    if sort_attribute == "platform"
      if sort_attribute_2 == "xbone"
        @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 2').references(:platformed_games).order(:name)
      elsif sort_attribute_2 == "ps4"
        @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 1').references(:platformed_games).order(:name)
      elsif sort_attribute_2 == "pc"
        @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 4').references(:platformed_games).order(:name)
      elsif sort_attribute_2 == "wiiu"
        @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 3').references(:platformed_games).order(:name)
      end
    else
      @games = Game.order(:name)
    end

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

  def destroy

    game = Game.find_by(id: params[:id])
    game.destroy
    flash[:warning] = "Game deleted!"
    redirect_to "/games"

  end

end
