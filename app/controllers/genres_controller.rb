class GenresController < ApplicationController

  before_action :authenticate_admin!

  def new
    
  end

  def create

    genre = Genre.new(name: params[:name])

    if genre.save
      flash[:success] = "Genre Created!"
      redirect_to '/games'
    else
      flash[:danger] = "Error!"
      redirect_to '/genres/new'
    end
    
  end

end
