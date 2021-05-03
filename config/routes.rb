Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :artists, :albums, :tracks

  put '/artists/:artist_id/albums/play', to: 'artists#play'
  put '/albums/:album_id/tracks/play', to: 'albums#play'
  put '/tracks/:track_id/play', to: 'tracks#play'
  get '/artists/:artist_id/tracks', to: 'tracks#index'

  resources :albums do
    resources :tracks
  end

  resources :artists do
    resources :albums
  end

end
