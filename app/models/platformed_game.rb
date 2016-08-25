class PlatformedGame < ApplicationRecord

  belongs_to :game
  belongs_to :platform
  has_many :deals

  def discount_value(deal)
    discount = (( self.base_price - deal.price ) / self.base_price ) * 100
    return discount.to_i
  end
  
end
