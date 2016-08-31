task :create_games_test_2 => :environment do

  offset = 0
  games_api = []

  while offset < 100

    current_list = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&offset=#{offset}",
      headers:{
        "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
        "Accept" => "application/json"
      }).body
    offset += 50
    puts "adding #{current_list.length} new things"
    current_list.each do |current_item|
      games_api << current_item
    end

  end

  puts games_api.length

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

    if game_api["release_dates"]
      game_api["release_dates"].each do |platformed_game|
        platformed_game = PlatformedGame.new(
          game_id: platformed_game["id"],
          platform_id: platformed_game["platform"],
          release_date: Date.strptime("#{platformed_game["date"]}", "%Q")
          )
        platformed_game.save
      end
    end

    if game_api["genres"]
      game_api["genres"].each do |genre_id|
        genred_game = GenredGame.new(
          game_id: game_api["id"],
          genre_id: genre_id
          )
        genred_game.save
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