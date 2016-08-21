class UserGame < ApplicationRecord

  belongs_to :game
  belongs_to :user

  validate :game_id_unique, on: :create

  def game_id_unique

    duplicates = UserGame.where(user_id: user_id, game_id: game_id)

    if !duplicates.empty?
      errors.add(:game_id, "can't add the same game")
    end

  end

end
