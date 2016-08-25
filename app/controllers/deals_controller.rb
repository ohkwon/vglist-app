class DealsController < ApplicationController

  before_action :authenticate_user!

  def new

  end

  def create

    deal = Deal.new(
      platformed_game_id: params[:platformed_game_id],
      retailer: params[:retailer],
      price: params[:price],
      date: params[:date],
      url: params[:url],
      active: true
      )
    if deal.save
      flash[:success] = "Deal added to game!"
      redirect_to "/games/#{params[:game_id]}"
    else
      flash[:danger] = "Error"
      redirect_to "/deals/#{params[:platformed_game_id]}/new"
    end
    
  end

  def index

    @platformed_game = PlatformedGame.find_by(id: params[:id])
    # @deals = []
    # @game.platformed_games.each do |platformed_game|
    #   platformed_game.deals.each do |deal|
    #     @deals << deal if deal
    #   end
    # end
    # return @deals = @deals.sort_by {|deal| deal.price}
    
  end

  def edit

    @deal = Deal.find_by(id: params[:id])

  end

  def update

    deal = Deal.find_by(id: params[:id])

    deal.assign_attributes(
      platformed_game_id: params[:platformed_game_id],
      retailer: params[:retailer],
      price: params[:price],
      date: params[:date],
      url: params[:url],
      active: params[:active]
      )

    if deal.save
      flash[:success] = "Deal edited!"
      redirect_to "/games/#{deal.platformed_game.game_id}"
    else
      flash[:danger] = "Error"
      redirect_to "/deals/#{deal.id}/edit"
    end

  end

end
