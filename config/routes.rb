EarthquakeList::Application.routes.draw do
  get "static_pages/root"  
  get '/earthquakes', to: 'earthquakes#index'
  # root :to => "static_pages#root"
end
