Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: 'gyms#index'

  resources "gyms"

  get '/search', to: 'gyms#search'

end
