Rails.application.routes.draw do

  get '/games', to: 'games#index'
  get '/games/index', to: 'games#index'

  get '/sign_up', to: 'users#new'
  post '/users', to: 'users#create'

  get '/user_games', to: 'user_games#index'
  get '/user_games/index', to: 'user_games#index'

end
