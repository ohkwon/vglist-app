Rails.application.routes.draw do

  get '/games', to: 'games#index'
  get '/games/index', to: 'games#index'
  get '/games/new', to: 'games#new'
  post '/games', to: 'games#create'
  get '/games/:id/edit', to: 'games#edit'
  patch '/games/:id', to: 'games#update'
  get '/games/:id', to: 'games#show'

  get '/sign_up', to: 'users#new'
  post '/users', to: 'users#create'

  get '/user_games', to: 'user_games#index'
  get '/user_games/index', to: 'user_games#index'
  post '/user_games', to: 'user_games#create'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/platforms', to: 'platforms#index'
  get '/platforms/index', to: 'platforms#index'
  get '/platforms/new', to: 'platforms#new'
  post '/platforms', to: 'platforms#create'

  get '/platformed_games/new', to: 'platformed_games#new'
  post '/platformed_games', to: 'platformed_games#create'

  get '/genres/new', to: 'genres#new'
  post '/genres', to: 'genres#create'

  get '/genred_games/new', to: 'genred_games#new'
  post '/genred_games', to: 'genred_games#create'

end