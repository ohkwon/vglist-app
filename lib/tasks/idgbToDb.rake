#complete api grab

offset = 0
games_api = []
current_list = ['start']

while offset < 9950
  current_list = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&order=created_at%3Aasc&offset=#{offset}",
    headers:{
      "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
      "Accept" => "application/json"
    }).body
  puts "on offset #{offset} going down"
  offset += 50
  current_list.each do |current_item|
    games_api << current_item
  end
  puts "game grab at #{games_api.length} items"
end

offset = 0

while offset < 9950
  current_list = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=50&order=created_at%3Adesc&offset=#{offset}",
    headers:{
      "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
      "Accept" => "application/json"
    }).body
  puts "on offset #{offset} going up"
  offset += 50
  current_list.each do |current_item|
    games_api << current_item_
  end
  puts "game grab at #{games_api.length} items"
end


# def sample_games_api_grab

  # games_api = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/games/?fields=*&limit=20&search=zelda",
  #       headers:{
  #         "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T",
  #         "Accept" => "application/json"
  #       }).body

# end

desc 'create entire database'
task :create_all do

  Rake::Task['create_genres'].invoke
  Rake::Task['create_platforms'].invoke
  Rake::Task['create_platform_logos'].invoke
  Rake::Task['create_games'].invoke
  Rake::Task['create_platformed_games'].invoke
  Rake::Task['create_genred_games'].invoke
  Rake::Task['create_covers'].invoke
  Rake::Task['create_screenshots'].invoke
  Rake::Task['create_videos'].invoke

end

desc 'update entire database'
task :update_all => :environment do

  Genre.delete_all()
  Platform.delete_all()
  PlatformLogo.delete_all()
  Game.delete_all()
  PlatformedGame.delete_all()
  GenredGame.delete_all()
  GameCover.delete_all()
  GameScreenshot.delete_all()
  GameVideo.delete_all()
  Rake::Task['create_genres'].invoke
  Rake::Task['create_platforms'].invoke
  Rake::Task['create_platform_logos'].invoke
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
      summary: game_api["summary"],
      storyline: game_api["storyline"],
      igdb_created_at: DateTime.strptime("#{game_api["created_at"]}", "%s"),
      igdb_updated_at: DateTime.strptime("#{game_api["updated_at"]}", "%s")
      )
    game.save

  end

end

desc 'update games db'
task :update_games => :environment do  

  counter = 1

  games_api.each do |game_api|

    puts "creating game #{counter} of #{games_api.length}"
    counter += 1

    game = Game.new(
      id: game_api["id"],
      name: game_api["name"],
      slug: game_api["slug"],
      summary: game_api["summary"],
      storyline: game_api["storyline"],
      igdb_created_at: DateTime.strptime("#{game_api["created_at"]}", "%s"),
      igdb_updated_at: DateTime.strptime("#{game_api["updated_at"]}", "%s")
      )
    game.save

  end

end

desc 'create platformed games db'
task :create_platformed_games => :environment do

  counter = 1

  games_api.each do |game_api|
    if game_api["release_dates"]
      counter1 = 1
      if game_api["release_dates"].any? { |platformed_game| platformed_game["region"] == 2 }
        game_api["release_dates"].each do |platformed_game|
          if platformed_game["date"] && platformed_game["region"] = 2 && !(PlatformedGame.where(game_id: game_api["id"], platform_id: platformed_game["platform"]).any?)
            puts "creating platformed game #{counter1} of #{counter}"
            puts "WW"
            new_platformed_game = PlatformedGame.new(
              game_id: game_api["id"],
              platform_id: platformed_game["platform"],
              release_date: Date.strptime("#{platformed_game['date']}", "%Q") 
              )
            new_platformed_game.save
            counter1 += 1
          end
        end
      elsif game_api["release_dates"].any? { |platformed_game| platformed_game["region"] == 8 }
        game_api["release_dates"].each do |platformed_game|
          if platformed_game["date"] && platformed_game["region"] = 8 && !(PlatformedGame.where(game_id: game_api["id"], platform_id: platformed_game["platform"]).any?)
            puts "creating platformed game #{counter1} of #{counter}"
            puts "US"
            new_platformed_game = PlatformedGame.new(
              game_id: game_api["id"],
              platform_id: platformed_game["platform"],
              release_date: Date.strptime("#{platformed_game['date']}", "%Q")
              )
            new_platformed_game.save
            counter1 += 1
          end
        end
      elsif
        game_api["release_dates"].each do |platformed_game|
          if !(platformed_game["region"]) && !(PlatformedGame.where(game_id: game_api["id"], platform_id: platformed_game["platform"]).any?)
            if platformed_game["date"]
              puts "creating platformed game #{counter1} of #{counter}"
              puts "no region"
              new_platformed_game = PlatformedGame.new(
                game_id: game_api["id"],
                platform_id: platformed_game["platform"],
                release_date: Date.strptime("#{platformed_game['date']}", "%Q")
                )
              new_platformed_game.save
              counter1 += 1
            end
          end
        end
      end
    end
    counter += 1
  end

end

desc 'create genred games db'
task :create_genred_games => :environment do

  counter = 1

  games_api.each do |game_api|
    if game_api["genres"]
      counter1 = 1
      game_api["genres"].each do |genre_id|
        puts "creating genred game #{counter1} of game #{counter} of #{games_api.length}"
        genred_game = GenredGame.new(
          game_id: game_api["id"],
          genre_id: genre_id
          )
        genred_game.save
        counter1 += 1
      end
    end
    counter += 1
  end

end

desc 'create covers db'
task :create_covers => :environment do

  counter = 1

  games_api.each do |game_api|
    if game_api["cover"]
      puts "creating game cover #{counter}"
      game_cover = GameCover.new(
        game_id: game_api["id"],
        cloudinary_id: game_api["cover"]["cloudinary_id"],
        width: game_api["cover"]["width"],
        height: game_api["cover"]["height"]
        )
      game_cover.save
    end
    counter += 1
  end

end

desc 'create screenshots db'
task :create_screenshots => :environment do

  counter = 1

  games_api.each do |game_api|
    if game_api["screenshots"]
      counter1 = 1
      game_api["screenshots"].each do |screenshot|
        puts "creating screenshot #{counter1} of game #{counter}"
        counter1 += 1
        game_screenshot = GameScreenshot.new(
          game_id: game_api["id"],
          cloudinary_id: screenshot["cloudinary_id"],
          width: screenshot["width"],
          height: screenshot["height"]
          )
        game_screenshot.save
      end
    end
    counter += 1
  end

end

desc 'create videos db'
task :create_videos => :environment do

  counter = 1

  games_api.each do |game_api|
    if game_api["videos"]
      counter1 = 1
      game_api["videos"].each do |video|
        puts "creating video #{counter1} of game #{counter}"
        counter += 1
        game_video = GameVideo.new(
          game_id: game_api["id"],
          name: video["name"],
          video_id: video["video_id"]
          )
        game_video.save
      end
    end
    counter += 1
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


def grab_platforms_api

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

  return platforms_api

end

desc 'create platforms db'
task :create_platforms => :environment do

  platforms_api = grab_platforms_api

  counter = 1 

  version_0 = [7, 9, 42, 44, 45, 46, 70]

  platforms_api.each do |platform_api|
    if platform_api["versions"].any? { |version| version["name"] == "Initial version"}
      index = platform_api["versions"].index { |version| version["name"] == "Initial version"}
      if platform_api["versions"][index]["release_dates"]
        if platform_api["versions"][index]["release_dates"].any? { |release_date| release_date["region"] == 8 }
          platform_api["versions"][index]["release_dates"].each do |release_date|
            if release_date["region"] == 8
              puts "creating platform #{counter} of #{platforms_api.length}"
              puts "name: #{platform_api['name']}"
              puts "WW"
              p release_date

              platform = Platform.new(
                id: platform_api["id"],
                name: platform_api["name"],
                slug: platform_api["slug"],
                release_date: Date.strptime("#{release_date['date']}", "%Q")
                )
              platform.save
              break
            end
          end
        elsif platform_api["versions"][index]["release_dates"].any? { |release_date| release_date["region"] == 2 }
          platform_api["versions"][index]["release_dates"].each do |release_date|
            if release_date["region"] == 2
              puts "creating platform #{counter} of #{platforms_api.length}"
              puts "name: #{platform_api['name']}"
              puts "US"
              p release_date

              platform = Platform.new(
                id: platform_api["id"],
                name: platform_api["name"],
                slug: platform_api["slug"],
                release_date: Date.strptime("#{release_date['date']}", "%Q")
                )
              platform.save
              break
            end
          end
        end
      else
        puts "creating platform #{counter} of #{platforms_api.length}"
        puts "name: #{platform_api['name']}"
        puts "No Release Date"

        platform = Platform.new(
          id: platform_api["id"],
          name: platform_api["name"],
          slug: platform_api["slug"]
          )
        platform.save
      end
    elsif platform_api["versions"].any? { |version| version["name"].include? "original" }
      index = platform_api["versions"].index { |version| version["name"].include? "original" }
      if platform_api["versions"][index]["release_dates"]
        if platform_api["versions"][index]["release_dates"].any? { |release_date| release_date["region"] == 8 }
          platform_api["versions"][index]["release_dates"].each do |release_date|
            if release_date["region"] == 8
              puts "creating platform #{counter} of #{platforms_api.length}"
              puts "name: #{platform_api['name']}"
              puts "WW"
              p release_date

              platform = Platform.new(
                id: platform_api["id"],
                name: platform_api["name"],
                slug: platform_api["slug"],
                release_date: Date.strptime("#{release_date['date']}", "%Q")
                )
              platform.save
              break
            end
          end
        elsif platform_api["versions"][index]["release_dates"].any? { |release_date| release_date["region"] == 2 }
          platform_api["versions"][index]["release_dates"].each do |release_date|
            if release_date["region"] == 2
              puts "creating platform #{counter} of #{platforms_api.length}"
              puts "name: #{platform_api['name']}"
              puts "US"
              p release_date

              platform = Platform.new(
                id: platform_api["id"],
                name: platform_api["name"],
                slug: platform_api["slug"],
                release_date: Date.strptime("#{release_date['date']}", "%Q")
                )
              platform.save
              break
            end
          end
        end
      end
    elsif platform_api["versions"].any? { |version| version["name"].include? "Original" }
      index = platform_api["versions"].index { |version| version["name"].include? "Original" }
      if platform_api["versions"][index]["release_dates"]
        if platform_api["versions"][index]["release_dates"].any? { |release_date| release_date["region"] == 8 }
          platform_api["versions"][index]["release_dates"].each do |release_date|
            if release_date["region"] == 8
              puts "creating platform #{counter} of #{platforms_api.length}"
              puts "name: #{platform_api['name']}"
              puts "WW"
              p release_date

              platform = Platform.new(
                id: platform_api["id"],
                name: platform_api["name"],
                slug: platform_api["slug"],
                release_date: Date.strptime("#{release_date['date']}", "%Q")
                )
              platform.save
              break
            end
          end
        elsif platform_api["versions"][index]["release_dates"].any? { |release_date| release_date["region"] == 2 }
          platform_api["versions"][index]["release_dates"].each do |release_date|
            if release_date["region"] == 2
              puts "creating platform #{counter} of #{platforms_api.length}"
              puts "name: #{platform_api['name']}"
              puts "US"
              p release_date

              platform = Platform.new(
                id: platform_api["id"],
                name: platform_api["name"],
                slug: platform_api["slug"],
                release_date: Date.strptime("#{release_date['date']}", "%Q")
                )
              platform.save
              break
            end
          end
        elsif platform_api["name"] == "PlayStation 3"
          platform_api["versions"][index]["release_dates"].each do |release_date|
            if release_date["region"] == 5
              puts "creating platform #{counter} of #{platforms_api.length}"
              puts "name: #{platform_api['name']}"
              puts "JP"
              p release_date

              platform = Platform.new(
                id: platform_api["id"],
                name: platform_api["name"],
                slug: platform_api["slug"],
                release_date: Date.strptime("#{release_date['date']}", "%Q")
                )
              platform.save
              break
            end
          end
        end
      end
    elsif platform_api["id"] == 14 || platform_api["id"] == 6 || platform_api["id"] == 34
      puts "ID: " + platform_api["id"].to_s
      hash = {}
      platform_api["versions"].each_with_index do |version, index|
        if hash.empty?
          hash = { date: version["release_dates"][0]["date"], index: index }
        elsif version["release_dates"][0]["date"] > hash[:date]
          hash = { date: version["release_dates"][0]["date"], index: index}
        end
      end
      puts "creating platform #{counter} of #{platforms_api.length}"
      puts "name: #{platform_api['name']}, version: #{platform_api['versions'][hash[:index]]['name']}"
      puts hash[:date]
      data = hash[:date]
      date = Date.strptime("#{data}", '%Q')
      platform = Platform.new(
        id: platform_api["id"],
        name: platform_api["name"],
        slug: platform_api["slug"],
        release_date: date
      )
      platform.save
    elsif version_0.include?(platform_api['id'])
      puts "name: #{platform_api['name']}"
      if platform_api["id"] == 9
        platform_api["versions"][0]['release_dates'].each do |release_date|
          if release_date["region"] == 5
            puts "creating platform #{counter} of #{platforms_api.length}"
            puts "name: #{platform_api['name']}"
            platform = Platform.new(
              id: platform_api["id"],
              name: platform_api["name"],
              slug: platform_api["slug"],
              release_date: Date.strptime("#{release_date['date']}", "%Q")
            )
            platform.save
          end
        end
      else
        platform_api["versions"][0]["release_dates"].each do |release_date|
          if release_date["region"] == 8
            puts "creating platform #{counter} of #{platforms_api.length}"
            puts "name: #{platform_api['name']}"
            platform = Platform.new(
              id: platform_api["id"],
              name: platform_api["name"],
              slug: platform_api["slug"],
              release_date: Date.strptime("#{release_date['date']}", "%Q")
            )
            platform.save
          elsif release_date["region"] == 2
            puts "creating platform #{counter} of #{platforms_api.length}"
            puts "name: #{platform_api['name']}"
            platform = Platform.new(
              id: platform_api["id"],
              name: platform_api["name"],
              slug: platform_api["slug"],
              release_date: Date.strptime("#{release_date['date']}", "%Q")
            )
            platform.save
          end
        end
      end
    else
      puts "creating platform #{counter} of #{platforms_api.length}"
      puts "name: #{platform_api['name']}"
      puts "No Release Date"

      platform = Platform.new(
        id: platform_api["id"],
        name: platform_api["name"],
        slug: platform_api["slug"]
        )
      platform.save
    end
    counter += 1
  end
end

desc 'create platform logos db'
task :create_platform_logos => :environment do

  platforms_api = grab_platforms_api

  platforms_api.each do |platform_api|

    if platform_api["logo"]

      puts "creating platform logo for platform #{platform_api['id']}"

      platform_logo = PlatformLogo.new(
        platform_id: platform_api["id"],
        cloudinary_id: platform_api["logo"]["cloudinary_id"],
        width: platform_api["logo"]["width"],
        height: platform_api["logo"]["height"]
        )
      platform_logo.save

    end

  end

end


