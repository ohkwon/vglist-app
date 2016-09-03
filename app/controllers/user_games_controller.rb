class UserGamesController < ApplicationController

  before_action :authenticate_user!

  def index

    sort_attribute = params[:sort_attribute]
    sort_attribute_2 = params[:sort_attribute_2]

    if sort_attribute == "platform"
      @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: sort_attribute_2}).order("games.name")
      # if sort_attribute_2 == "1"
      #   @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: 1}).order("games.name") #ps4
      # elsif sort_attribute_2 == "2"
      #   @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: 2}).order("games.name") #xbone
      # elsif sort_attribute_2 == "3"
      #   @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: 3}).order("games.name") #wii u
      # elsif sort_attribute_2 == "4"
      #   @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games: {platform_id: 4}).order("games.name") #pc
      # end
    elsif sort_attribute == "genre"
        @user_games = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: sort_attribute_2})
      # if sort_attribute_2 == "1"
      #   @user_games = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: 1}) #action-rpg
      # elsif sort_attribute_2 == "2"
      #   @user_games = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: 2}) #fps
      # elsif sort_attribute_2 == "3"
      #   @user_games = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: 3}) #survival-horror
      # elsif sort_attribute_2 == "4"
      #   @user_games = current_user.user_games.joins(game: :genred_games).where(genred_games: {genre_id: 4}) #action-rpg
      # end
    elsif sort_attribute == "owned"
      @user_games = current_user.user_games.where(ownership: true).joins(:game).order("games.name")
    elsif sort_attribute == "wanted"
      @user_games = current_user.user_games.where(ownership: false).joins(:game).order("games.name")
    # elsif sort_attribute_2 == "price"
    #   @user_games = current_user.user_games.joins(game: :platformed_games).where(platformed_games:)
    else
      @user_games = current_user.user_games.joins(:game).order(:ownership).order("games.name")
    end


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
