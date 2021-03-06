Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  ActiveAdmin.routes(self)

  devise_for :users, controllers: { registrations: "users/registrations" }
  root to: 'gyms#index'

  resources "gyms"

  get '/index_locked', to: 'gyms#index_locked', as: 'index_locked'
  get '/search', to: 'gyms#search'
  get '/approve/:id', to: 'gyms#approve', as: 'approve'

  get '/token', to: 'users#get_token', as: 'get_token'
  get '/token/:id', to: 'users#use_token', as: 'use_token'

  get '/list_gym_token', to: 'users#index_manager', as: 'list_gym_tokens'
  get '/reg_user_token', to: 'users#index_regular', as: 'reg_user_tokens'

  get '/show_manager/:id', to: 'users#show_manager', as: 'show_manager'
  get '/validate_token/:id', to: 'users#validate_user_token', as: 'validate_token'

end
