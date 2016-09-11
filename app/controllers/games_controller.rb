class GamesController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :index_2, :show]

  def index

    sort_attribute = params[:sort_attribute]
    sort_attribute_2 = params[:sort_attribute_2]
    if sort_attribute == "platform"
      @games = Game.includes(:platformed_games).where("platformed_games.platform_id = #{sort_attribute_2}").references(:platformed_games).order(:name)
      # if sort_attribute_2 == "1"
      #   @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 1').references(:platformed_games).order(:name) #ps4
      # elsif sort_attribute_2 == "2"
      #   @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 2').references(:platformed_games).order(:name) #xbone
      # elsif sort_attribute_2 == "3"
      #   @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 3').references(:platformed_games).order(:name) #wii u
      # elsif sort_attribute_2 == "4"
      #   @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 4').references(:platformed_games).order(:name) #pc
      # end
    elsif sort_attribute == "genre"
      @games = Game.includes(:genred_games).where("genred_games.genre_id = #{sort_attribute_2}").references(:genred_games).order(:name)
      # if sort_attribute_2 == "1"
      #   @games = Game.includes(:genred_games).where('genred_games.genre_id = 1').references(:genred_games).order(:name) #action-rpg
      # elsif sort_attribute_2 == "2"
      #   @games = Game.includes(:genred_games).where('genred_games.genre_id = 2').references(:genred_games).order(:name) #fps
      # elsif sort_attribute_2 == "3"
      #   @games = Game.includes(:genred_games).where('genred_games.genre_id = 3').references(:genred_games).order(:name) #survival-horror
      # elsif sort_attribute_2 == "4"
      #   @games = Game.includes(:genred_games).where('genred_games.genre_id = 4').references(:genred_games).order(:name) #action-rpg
      # end
    else
      @games = Game.where("name LIKE ?", "%Metal Gear Solid%").order(:name).limit(15)
    end
    # binding.pry

  end

  def index_2
    @counter = 12

    sort_attribute = params[:sort_attribute]
    sort_attribute_2 = params[:sort_attribute_2]
    if sort_attribute == "platform"
      @games = Game.includes(:platformed_games).where("platformed_games.platform_id = #{sort_attribute_2}").references(:platformed_games).order(:name)
      # if sort_attribute_2 == "1"
      #   @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 1').references(:platformed_games).order(:name) #ps4
      # elsif sort_attribute_2 == "2"
      #   @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 2').references(:platformed_games).order(:name) #xbone
      # elsif sort_attribute_2 == "3"
      #   @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 3').references(:platformed_games).order(:name) #wii u
      # elsif sort_attribute_2 == "4"
      #   @games = Game.includes(:platformed_games).where('platformed_games.platform_id = 4').references(:platformed_games).order(:name) #pc
      # end
    elsif sort_attribute == "genre"
      @games = Game.includes(:genred_games).where("genred_games.genre_id = #{sort_attribute_2}").references(:genred_games).order(:name)
      # if sort_attribute_2 == "1"
      #   @games = Game.includes(:genred_games).where('genred_games.genre_id = 1').references(:genred_games).order(:name) #action-rpg
      # elsif sort_attribute_2 == "2"
      #   @games = Game.includes(:genred_games).where('genred_games.genre_id = 2').references(:genred_games).order(:name) #fps
      # elsif sort_attribute_2 == "3"
      #   @games = Game.includes(:genred_games).where('genred_games.genre_id = 3').references(:genred_games).order(:name) #survival-horror
      # elsif sort_attribute_2 == "4"
      #   @games = Game.includes(:genred_games).where('genred_games.genre_id = 4').references(:genred_games).order(:name) #action-rpg
      # end
    else
      @games = Game.where("name LIKE ?", "%Metal Gear Solid%").order(:name).limit(15)
    end
    # binding.pry

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
