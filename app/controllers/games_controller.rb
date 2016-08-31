class GamesController < ApplicationController

  before_action :authenticate_admin!, except: [:index, :show]

  def index
    offset = 0
    @games = []
    puts "run page start"
    while offset < 50
      game_hashes = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&order=release_dates.date%3Adesc&offset=#{offset}",
        headers:{
          "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
          "Accept" => "application/json"
         }).body
      puts "https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&offset=#{offset}"
      offset += 50
      game_hashes.each do |game_hash|
        @games << Game.new(game_hash)
      end    
      if game_hashes.length < 50
        break
      end
    end

    @platforms = []
    offset = 0

    while offset < 200
      platform_hashes = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/platforms/?fields=*&limit=50&offset=#{offset}",
        headers:{
          "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
          "Accept" => "application/json"
          }).body
      offset += 50
      platform_hashes.each do |platform_hash|
        @platforms << Platform.new(platform_hash) if platform_hash["games"]
      end
      if platform_hashes.length < 50
        break
      end
    end

    @genres = []
    genre_hashes = Unirest.get( "https://igdbcom-internet-game-database-v1.p.mashape.com/genres/?fields=*",
      headers:{
          "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
          "Accept" => "application/json"
        }).body
    genre_hashes.each do |genre_hash|
      @genres << Genre.new(genre_hash)
    end

  end

  def show
    offset = 0
    @game = nil
    puts "start check"
    until @game
      puts "start offset #{offset}"
      game_hash_find = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&offset=#{offset}&search=#{params[:slug]}",
        headers:{
          "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
          "Accept" => "application/json"
        }).body
      puts "checking https://igdbcom-internet-game-database-v1.p.mashape.com/
                      games/?fields=*&limit=50&offset=#{offset}&search=#{params[:slug]}"
      offset += 50
      game_hash_find.each do |game_hash|
        if game_hash["id"] == params[:id].to_i
          @game = Game.new(game_hash)
          break
        end
      end
    end

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
