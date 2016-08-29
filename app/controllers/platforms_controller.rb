class PlatformsController < ApplicationController

  before_action :authenticate_admin!

  def index

    platform_hashes = Unirest.get("https://igdbcom-internet-game-database-v1.p.mashape.com/platforms/?fields=*",
      headers:{
        "X-Mashape-Key" => "arQcHPrN6ImshNKxsi3eTD0FYt7vp18kzZnjsnq60XoEEn991T"
        }).body

    @platforms = []

    platform_hashes.each do |platform_hash|
      @platforms << Platform.new(platform_hash)
    end

  end

  def new

  end

  def create

    platform = Platform.new(
      name: params[:name]
      )

    if platform.save
      flash[:success] = "Platform added!"
      redirect_to '/platforms'
    else
      flash[:danger] = "Error!"
      redirect_to '/platforms/new'
    end

  end

end
