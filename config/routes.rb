Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'dragon/new'
  get 'resource/new'
  get 'dragon_types/index'
  get 'dragons_teams/index'
  get 'resources/index'
  get 'expeditions/index'
  root 'dragon_types#index'

  resources :dragons_teams
  resources :dragon_types
  resources :resources
  resources :resource_types

  resources :expeditions
  resources :expedition_types
  resources :expedition_prizes

  namespace :user do
    root to: 'profile#index'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
