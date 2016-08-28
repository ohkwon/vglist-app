# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user1 = UserGenre.new(user_id: 2, game_id: 3, genre_id: 2)
user1.save
user2 = UserGenre.new(user_id: 2, game_id: 4, genre_id: 4)
user2.save
