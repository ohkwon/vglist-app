task :create_games_test_1 => :environment do  

  games_api = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=2&offset=0&search=zelda",
    headers:{
      "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
      "Accept" => "application/json"
    }).body

  games_api.each do |game_api|
    puts "creating new game"
    game = Game.new(
      id: game_api["id"],
      name: game_api["name"],
      slug: game_api["slug"],
      summary: game_api["slug"],
      storyline: game_api["storyline"],
      igdb_created_at: Time.strptime("#{game_api["created_at"]}", "%Q"),
      igdb_updated_at: Time.strptime("#{game_api["updated_at"]}", "%Q")
      )
    game.save

    p game_api["release_dates"]

    if game_api["release_dates"]
      game_api["release_dates"].each do |platformed_game|
        puts "creating platformed game"
        puts game_api["id"]
        platformed_game = PlatformedGame.new(
          game_id: game_api["id"],
          platform_id: platformed_game["platform"],
          release_date: Date.strptime("#{platformed_game["date"]}", "%Q")
          )
        platformed_game.save
        p platformed_game
      end
    end

    p game_api["genres"]

    if game_api["genres"]
      game_api["genres"].each do |genre_id|
        puts "creating genred game"
        puts game_api["id"]
        genred_game = GenredGame.new(
          game_id: game_api["id"],
          genre_id: genre_id
          )
        genred_game.save
        p genred_game
      end
    end

    if game_api["cover"]
      game_cover = GameCover.new(
        game_id: game_api["id"],
        cloudinary_id: game_api["cover"]["cloudinary_id"],
        width: game_api["cover"]["width"],
        height: game_api["cover"]["height"]
        )
      game_cover.save
    end

    if game_api["screenshots"]
      game_api["screenshots"].each do |screenshot|
        game_screenshot = GameScreenshot.new(
          game_id: game_api["id"],
          cloudinary_id: screenshot["cloudinary_id"],
          width: screenshot["width"],
          height: screenshot["height"]
          )
        game_screenshot.save
      end
    end

    if game_api["videos"]
      game_api["videos"].each do |video|
        game_video = GameVideo.new(
          game_id: game_api["id"],
          name: video["name"],
          video_id: video["video_id"]
          )
        game_video.save
      end
    end

  end

end

task :create_genres => :environment do

  genres_api = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/genres/?fields=*&limit=50",
  headers:{
    "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T"
  }).body

  genres_api.each do |genre_api|
    puts "creating new genre"
    genre = Genre.new(
      id: genre_api["id"],
      name: genre_api["name"],
      slug: genre_api["slug"]
      )
    genre.save
  end

end

task :create_platforms => :environment do

  offset = 0
  platforms_api = []

  while offset < 150

    current_list = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/platforms/?fields=*&limit=50&offset=#{offset}",
    headers:{
      "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T"
    }).body

    puts offset
    offset += 50

    current_list.each do |platform|
      platforms_api << platform if platform["games"]
    end

    if current_list.length < 50
      break
    end

  end

  platforms_api.each do |platform_api|
    puts "creating new platform"
    platform = Platform.new(
      id: platform_api["id"],
      name: platform_api["name"],
      slug: platform_api["slug"]
      )
    platform.save
  end

end



