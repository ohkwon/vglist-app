class PlatformsController < ApplicationController

  def index

    @platforms = Platform.all

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
