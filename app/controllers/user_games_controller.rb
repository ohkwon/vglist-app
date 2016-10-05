class UserGamesController < ApplicationController

  before_action :authenticate_user!

  def index

    @limit = 25
    @page = 1
    @search = ""

    if params[:page]
      @page = params[:page]
    end

    @sort_attribute = params[:sort_attribute]
    @sort_attribute_2 = params[:sort_attribute_2]
    @filter = params[:filter]

    if @sort_attribute == "platform"
      if @filter == "name_up"
        @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("games.name").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("games.name").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("games.name").page(@page.to_i + 2).per(@limit)
      elsif @filter == "name_down"
        @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("games.name DESC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("games.name DESC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("games.name DESC").page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_desc"
        @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("platformed_games.release_date DESC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_asc"
        @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("platformed_games.release_date ASC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("platformed_games.release_date ASC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("platformed_games.release_date ASC").page(@page.to_i + 2).per(@limit)
      else
        @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order(created_at: :desc).page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order(created_at: :desc).page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order(created_at: :desc).page(@page.to_i + 2).per(@limit)
      end
    elsif @sort_attribute == "genre"
      if @filter == "name_up"
        @user_games = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: @sort_attribute_2}).order("games.name").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: @sort_attribute_2}).order("games.name").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: @sort_attribute_2}).order("games.name").page(@page.to_i + 2).per(@limit)
      elsif @filter == "name_down"
        @user_games = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: @sort_attribute_2}).order("games.name DESC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: @sort_attribute_2}).order("games.name DESC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: @sort_attribute_2}).order("games.name DESC").page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_desc"
        @user_games = current_user.user_games.joins(game: :genred_games).joins(game: :platformed_games).where(genred_games: {genre_id: @sort_attribute_2}).order("platformed_games.release_date DESC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :genred_games).joins(game: :platformed_games).where(genred_games: {genre_id: @sort_attribute_2}).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :genred_games).joins(game: :platformed_games).where(genred_games: {genre_id: @sort_attribute_2}) .order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_asc"
        @user_games = current_user.user_games.joins(game: :genred_games).joins(game: :platformed_games).where(genred_games: {genre_id: @sort_attribute_2}).order("platformed_games.release_date ASC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :genred_games).joins(game: :platformed_games).where(genred_games: {genre_id: @sort_attribute_2}).order("platformed_games.release_date ASC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :genred_games).joins(game: :platformed_games).where(genred_games: {genre_id: @sort_attribute_2}).order("platformed_games.release_date ASC").page(@page.to_i + 2).per(@limit)
      else
        @user_games = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: @sort_attribute_2}).order(created_at: :desc).page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: @sort_attribute_2}).order(created_at: :desc).page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: @sort_attribute_2}) .order(created_at: :desc).page(@page.to_i + 2).per(@limit)
      end
    elsif @sort_attribute == "owned"
      if @filter == "name_up"
        @user_games = current_user.user_games.where(ownership: true).joins(:game).order("games.name").page(@page).per(@limit)
        @user_games_next = current_user.user_games.where(ownership: true).joins(:game).order("games.name").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.where(ownership: true).joins(:game).order("games.name").page(@page.to_i + 2).per(@limit)
      elsif @filter == "name_down"
        @user_games = current_user.user_games.where(ownership: true).joins(:game).order("games.name DESC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.where(ownership: true).joins(:game).order("games.name DESC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.where(ownership: true).joins(:game).order("games.name DESC").page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_desc"
        @user_games = current_user.user_games.joins(game: :platformed_games).where(ownership: true).joins(:game).order("platformed_games.release_date DESC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :platformed_games).where(ownership: true).joins(:game).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(ownership: true).joins(:game).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_asc"
        @user_games = current_user.user_games.joins(game: :platformed_games).where(ownership: true).joins(:game).order("platformed_games.release_date ASC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :platformed_games).where(ownership: true).joins(:game).order("platformed_games.release_date ASC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(ownership: true).joins(:game).order("platformed_games.release_date ASC").page(@page.to_i + 2).per(@limit)
      else
        @user_games = current_user.user_games.where(ownership: true).joins(:game).order(created_at: :desc).page(@page).per(@limit)
        @user_games_next = current_user.user_games.where(ownership: true).joins(:game).order(created_at: :desc).page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.where(ownership: true).joins(:game).order(created_at: :desc).page(@page.to_i + 2).per(@limit)
      end
    elsif @sort_attribute == "wanted"
      if @filter == "name_up"
        @user_games = current_user.user_games.where(ownership: false).joins(:game).order("games.name").page(@page).per(@limit)
        @user_games_next = current_user.user_games.where(ownership: false).joins(:game).order("games.name").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.where(ownership: false).joins(:game).order("games.name").page(@page.to_i + 2).per(@limit)
      elsif @filter == "name_down"
        @user_games = current_user.user_games.where(ownership: false).joins(:game).order("games.name DESC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.where(ownership: false).joins(:game).order("games.name DESC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.where(ownership: false).joins(:game).order("games.name DESC").page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_desc"
        @user_games = current_user.user_games.joins(game: :platformed_games).where(ownership: false).order("platformed_games.release_date DESC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :platformed_games).where(ownership: false).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(ownership: false).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
      elsif @filter == "release_date_asc"
        @user_games = current_user.user_games.joins(game: :platformed_games).where(ownership: false).order("platformed_games.release_date ASC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :platformed_games).where(ownership: false).order("platformed_games.release_date ASC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(ownership: false).order("platformed_games.release_date ASC").page(@page.to_i + 2).per(@limit)
      else
        @user_games = current_user.user_games.joins(game: :platformed_games).where(ownership: false).order("platformed_games.release_date DESC").page(@page).per(@limit)
        @user_games_next = current_user.user_games.joins(game: :platformed_games).where(ownership: false).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
        @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(ownership: false).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
      end
    elsif @filter == "name_up"
      @user_games = current_user.user_games.joins(:game).order(:ownership).order("games.name").page(@page).per(@limit)
      @user_games_next = current_user.user_games.joins(:game).order(:ownership).order("games.name").page(@page.to_i + 1).per(@limit)
      @user_games_next_2 = current_user.user_games.joins(:game).order(:ownership).order("games.name").page(@page.to_i + 2).per(@limit)
    elsif @filter == "name_down"
      @user_games = current_user.user_games.joins(:game).order(:ownership).order("games.name DESC").page(@page).per(@limit)
      @user_games_next = current_user.user_games.joins(:game).order(:ownership).order("games.name DESC").page(@page.to_i + 1).per(@limit)
      @user_games_next_2 = current_user.user_games.joins(:game).order(:ownership).order("games.name DESC").page(@page.to_i + 2).per(@limit)
    elsif @filter == "release_date_desc"
      @user_games = current_user.user_games.joins(game: :platformed_games).order("platformed_games.release_date DESC").page(@page).per(@limit)
      @user_games_next = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("platformed_games.release_date DESC").page(@page.to_i + 1).per(@limit)
      @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("platformed_games.release_date DESC").page(@page.to_i + 2).per(@limit)
    elsif @filter == "release_date_asc"
      @user_games = current_user.user_games.joins(game: :platformed_games).order("platformed_games.release_date ASC").page(@page).per(@limit)
      @user_games_next = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("platformed_games.release_date ASC").page(@page.to_i + 1).per(@limit)
      @user_games_next_2 = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: @sort_attribute_2}).order("platformed_games.release_date ASC").page(@page.to_i + 2).per(@limit)
    else
      @user_games = current_user.user_games.order(:ownership).order(created_at: :desc).page(@page).per(@limit)
      @user_games_next = current_user.user_games.order(:ownership).order(created_at: :desc).page(@page.to_i + 1).per(@limit)
      @user_games_next_2 = current_user.user_games.order(:ownership).order(created_at: :desc).page(@page.to_i + 2).per(@limit)
    end

    if current_user.user_games.any? 
      @sample_game = @user_games.sample
      counter = 0
      until @sample_game.game.game_covers.any?
        @sample_game = @user_games.sample
        counter += 1
        if counter > 5
          break
        end
      end
      @platforms = []
      @genres = []
      current_user.user_games.each do |user_game|
        user_game.game.platformed_games.each do |platformed_game|
          if !@platforms.include?(Platform.find_by(id: platformed_game.platform_id))
            @platforms << Platform.find_by(id: platformed_game.platform_id)
          end
        end
        user_game.game.genred_games.each do |genred_game|
          if !@genres.include?(Genre.find_by(id: genred_game.genre_id))
            @genres << Genre.find_by(id: genred_game.genre_id)
          end
        end
      end

    end

    @users_page = 0

  end

  def create

    game_id_list = []

    current_user.user_games.each do |user_game|
      game_id_list << user_game.game_id
    end

    if !game_id_list.include?(params[:game_id])

      user_game = UserGame.new(
        game_id: params[:game_id],
        user_id: current_user.id,
        ownership: false
        )

      if user_game.save

        Game.find_by(id: params[:game_id]).genred_games.each do |genred_game|
          user_genre = UserGenre.create(
            game_id: params[:game_id],
            user_id: current_user.id,
            genre_id: genred_game.genre_id
            )
        end

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
    user_genres = UserGame.find_by(id: params[:id]).game.user_genres.where(user_id: current_user.id)
    user_genres.each do |user_genre|
      user_genre.destroy
    end
    user_game.destroy
    flash[:success] = "Game removed from list"
    redirect_to "/user_games"

  end

end
