class UserGamesController < ApplicationController

  def index

    @user_games = User_Games.all #will change to current user

  end

end
