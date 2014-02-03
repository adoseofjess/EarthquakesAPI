EarthquakeList::Application.routes.draw do
  get "form/index"

  get "static_pages/root"  
  get '/earthquakes', to: 'earthquakes#index'
  get '/form', to: 'form#index'
  root :to => "static_pages#root"
end
