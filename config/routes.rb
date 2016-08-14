Rails.application.routes.draw do

  get '/games/', to: 'games#index'
  get '/games/index', to: 'games#index'

end
