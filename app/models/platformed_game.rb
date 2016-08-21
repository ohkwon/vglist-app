class PlatformedGame < ApplicationRecord

  belongs_to :game
  belongs_to :platform
  has_many :deals
  
end
