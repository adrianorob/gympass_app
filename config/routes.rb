Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  ActiveAdmin.routes(self)
  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: 'gyms#index'

  resources "gyms"

  get '/search', to: 'gyms#search'

  get '/token/:id', to: 'gyms#get_token', as: 'token'

end
