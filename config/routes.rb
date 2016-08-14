Rails.application.routes.draw do

  get '/games/', to: 'games#index'
  get '/games/index', to: 'games#index'

  get '/sign_up', to: 'users#new'
  post '/users', to: 'users#create'

end
