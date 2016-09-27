Rails.application.routes.draw do

  get '/', to: 'games#index'
  get '/games', to: 'games#index'
  get '/games/index', to: 'games#index'
  get '/games/new', to: 'games#new'
  post '/games', to: 'games#create'
  get '/games/:id/edit', to: 'games#edit'
  patch '/games/:id', to: 'games#update'
  delete '/games/:id', to: 'games#destroy'
  get '/games/:id', to: 'games#show'

  get '/sign_up', to: 'users#new'
  post '/users', to: 'users#create'

  get '/user_games', to: 'user_games#index'
  get '/user_games/index', to: 'user_games#index'
  post '/user_games/:game_id', to: 'user_games#create'
  patch '/user_games/:id', to: 'user_games#update'
  delete '/user_games/:id', to: 'user_games#destroy'

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

  get '/deals/new/:game_id', to: 'deals#new'
  post '/deals', to: 'deals#create'
  # get '/deals/:id', to: 'deals#index'
  get '/deals/:id/edit', to: 'deals#edit'
  patch '/deals/:id', to: 'deals#update'

  post '/comments', to: 'comments#create'

end