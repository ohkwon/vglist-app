#complete api grab

# offset = 0
# games_api = []

# while offset < 100

#   current_list = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&offset=#{offset}",
#     headers:{
#       "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
#       "Accept" => "application/json"
#     }).body

#   offset += 50

#   current_list.each do |current_item|
#     games_api << current_item
#   end

# end


#sampled test grab

games_api = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=2&search=zelda",
      headers:{
        "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
        "Accept" => "application/json"
      }).body

desc 'create entire database'
task :create_all do

  Rake::Task['create_genres'].invoke
  Rake::Task['create_platforms'].invoke
  Rake::Task['create_games'].invoke
  Rake::Task['create_platformed_games'].invoke
  Rake::Task['create_genred_games'].invoke
  Rake::Task['create_covers'].invoke
  Rake::Task['create_screenshots'].invoke
  Rake::Task['create_videos'].invoke

end

desc 'create all database that is inseperable from games call'
task :create_games_and_associations do

  Rake::Task['create_games'].invoke
  Rake::Task['create_platformed_games'].invoke
  Rake::Task['create_genred_games'].invoke
  Rake::Task['create_covers'].invoke
  Rake::Task['create_screenshots'].invoke
  Rake::Task['create_videos'].invoke

end

desc 'create games db'
task :create_games => :environment do  

  counter = 1

  games_api.each do |game_api|

    puts "creating game #{counter} of #{games_api.length}"
    counter += 1

    game = Game.new(
      id: game_api["id"],
      name: game_api["name"],
      slug: game_api["slug"],
      summary: game_api["slug"],
      storyline: game_api["storyline"],
      igdb_created_at: DateTime.strptime("#{game_api["created_at"]}", "%s"),
      igdb_updated_at: DateTime.strptime("#{game_api["updated_at"]}", "%s")
      )
    game.save

  end

end

desc 'create platformed games db'
task :create_platformed_games => :environment do

  games_api.each do |game_api|
    if game_api["release_dates"]
      game_api["release_dates"].each do |platformed_game|
        platformed_game = PlatformedGame.new(
          game_id: game_api["id"],
          platform_id: platformed_game["platform"],
          release_date: Date.strptime("#{platformed_game["date"]}", "%Q")
          )
        platformed_game.save
      end
    end
  end

end

desc 'create genred games db'
task :create_genred_games => :environment do

  games_api.each do |game_api|
    if game_api["genres"]
      game_api["genres"].each do |genre_id|
        genred_game = GenredGame.new(
          game_id: game_api["id"],
          genre_id: genre_id
          )
        genred_game.save
      end
    end
  end

end

desc 'create covers db'
task :create_covers => :environment do

  games_api.each do |game_api|
    if game_api["cover"]
      game_cover = GameCover.new(
        game_id: game_api["id"],
        cloudinary_id: game_api["cover"]["cloudinary_id"],
        width: game_api["cover"]["width"],
        height: game_api["cover"]["height"]
        )
      game_cover.save
    end
  end

end

desc 'create screenshots db'
task :create_screenshots => :environment do

  games_api.each do |game_api|
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
  end

end

desc 'create videos db'
task :create_videos => :environment do

  games_api.each do |game_api|
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

desc 'create genres db'
task :create_genres => :environment do

  genres_api = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/genres/?fields=*&limit=50",
  headers:{
    "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T"
  }).body

  counter = 1

  genres_api.each do |genre_api|

    puts "creating genre #{counter} of #{genres_api.length}"
    counter += 1

    genre = Genre.new(
      id: genre_api["id"],
      name: genre_api["name"],
      slug: genre_api["slug"]
      )
    genre.save
  end

end

desc 'create platforms db'
task :create_platforms => :environment do

  offset = 0
  platforms_api = []

  while offset < 150

    current_list = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/platforms/?fields=*&limit=50&offset=#{offset}",
    headers:{
      "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T"
    }).body

    offset += 50

    current_list.each do |platform|
      platforms_api << platform if platform["games"]
    end

    if current_list.length < 50
      break
    end

  end

  counter = 1 

  platforms_api.each do |platform_api|

    puts "creating platform #{counter} of #{platforms_api.length}"
    counter += 1

    platform = Platform.new(
      id: platform_api["id"],
      name: platform_api["name"],
      slug: platform_api["slug"]
      )
    platform.save
  end

end



