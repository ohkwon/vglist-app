class DealsController < ApplicationController

  def new

  end

  def create

    deal = Deal.new(
      game_id: params[:game_id],
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
      redirect_to "/deals/#{params[:game_id]}/new"
    end
    
  end

  def show
    
  end

end
