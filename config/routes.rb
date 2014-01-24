EarthquakeList::Application.routes.draw do
  # resources :earthquakes
  
  get '/earthquakes', to: 'earthquakes#index'
end
