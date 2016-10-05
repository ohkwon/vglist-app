class GamesController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :index_2, :show]

  def index

    @limit = 20
    @page = 1
    @search = ""
    if params[:search]
      @search = params[:search]
    end
    if params[:page]
      @page = params[:page]
    end

    @sort_attribute = params[:sort_attribute]
    @sort_attribute_2 = params[:sort_attribute_2]
    @filter = params[:filter]

    if !@search.empty?
      @games = Game.where("name ILIKE ?", "%#{params[:search]}%").order(:name).page(@page).per(@limit)
      @games_next = Game.where("name ILIKE ?", "%#{params[:search]}%").order(:name).page(@page.to_i + 1).per(@limit)
      @games_next_2 = Game.where("name ILIKE ?", "%#{params[:search]}%").order(:name).page(@page.to_i + 2).per(@limit)
    elsif @sort_attribute == "platform"
      if @filter == "name_up"
        @games = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order(:name).page(@page).per(@limit)
        @games_next = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order(:name).page(@page.to_i + 1).per(@limit)
        @games_next_2 = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order(:name).page(@page.to_i + 2).per(@limit)
      elsif @filter == "name_down"
        @games = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order(name: :desc).page(@page).per(@limit)
        @games_next = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order(name: :desc).page(@page.to_i + 1).per(@limit)
        @games_next_2 = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order(name: :desc).page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_desc"
        @games = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page).per(@limit)
        @games_next = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
        @games_next_2 = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_asc"
        @games = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date ASC").page(@page).per(@limit)
        @games_next = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date ASC").page(@page.to_i + 1).per(@limit)
        @games_next_2 = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date ASC").page(@page.to_i + 2).per(@limit)
      else
        @games = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page).per(@limit)
        @games_next = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
        @games_next_2 = Game.includes(:platformed_games).where("platformed_games.platform_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
      end
    elsif @sort_attribute == "genre"
      if @filter == "name_up"
        @games = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order(:name).page(@page).per(@limit)
        @games_next = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order(:name).page(@page.to_i + 1).per(@limit)
        @games_next_2 = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order(:name).page(@page.to_i + 2).per(@limit)
      elsif @filter == "name_down"
        @games = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order(name: :desc).page(@page).per(@limit)
        @games_next = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order(name: :desc).page(@page.to_i + 1).per(@limit)
        @games_next_2 = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order(name: :desc).page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_desc"
        @games = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order("platformed_games.release_date DESC").page(@page).per(@limit)
        @games_next = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
        @games_next_2 = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_asc"
        @games = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order("platformed_games.release_date ASC").page(@page).per(@limit)
        @games_next = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order("platformed_games.release_date ASC").page(@page.to_i + 1).per(@limit)
        @games_next_2 = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order("platformed_games.release_date ASC").page(@page.to_i + 2).per(@limit)
      else
        @games = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order("platformed_games.release_date DESC").page(@page).per(@limit)
        @games_next = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
        @games_next_2 = Game.includes(:genred_games, :platformed_games).where("genred_games.genre_id = #{@sort_attribute_2}").where("platformed_games.id >= 0").references(:genred_games, :platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
      end
    elsif @filter == "name_up"
      @games = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order(:name).page(@page).per(@limit)
      @games_next = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order(:name).page(@page.to_i + 1).per(@limit)
      @games_next_2 = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order(:name).page(@page.to_i + 2).per(@limit)
    elsif @filter == "name_down"
      @games = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order(name: :desc).page(@page).per(@limit)
      @games_next = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order(name: :desc).page(@page.to_i + 1).per(@limit)
      @games_next_2 = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order(name: :desc).page(@page.to_i + 2).per(@limit)
    elsif @filter == "release_date_desc"
      @games = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page).per(@limit)
      @games_next = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
      @games_next_2 = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
    elsif @filter == "release_date_asc"
      @games = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date ASC").page(@page).per(@limit)
      @games_next = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date ASC").page(@page.to_i + 1).per(@limit)
      @games_next_2 = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date ASC").page(@page.to_i + 2).per(@limit)
    else
      @games = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page).per(@limit)
      @games_next = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
      @games_next_2 = Game.includes(:platformed_games).where("platformed_games.id >= 0").references(:platformed_games).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
    end

    @platforms_1 = Platform.where.not(release_date: nil).order(release_date: :desc)
    @platforms_2 = Platform.where(release_date: nil).order(:name)
    @platforms = @platforms_1 | @platforms_2
    @genres = Genre.all.order(:name)

    if @games.any?
      @sample_games = []
      index = 0 
      counter = 0
      until @sample_games.length >= 2
        sample = @games.includes(:game_covers).where("game_covers.id >= 0").references(:game_covers).sample
        if !@sample_games.include?(sample) && sample.game_covers
          @sample_games << sample
          index += 1
          counter = 0
        end
        counter += 1
        if counter == 5
          break
        end
      end
    end

  end

  def index_2
    @counter = 0

    sort_attribute= params[:sort_attribute]
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

  end

  def show

    @game = Game.find_by(id: params[:id])
    @game_images = []
    if @game.game_covers.any?
      @game_images << @game.game_covers.first
    end
    if @game.game_screenshots.any?
      @game.game_screenshots.each do |screenshot|
        @game_images << screenshot
      end
    end
    @index = 0
    @counter = 1

    @comments = @game.comments
    @reply_length = 0

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
