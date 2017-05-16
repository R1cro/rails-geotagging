Rails.application.routes.draw do
  devise_for :users

  root 'welcome#index'

  get "/search" => "dynamic_objects#search"

  resources :connections, only: [:create, :destroy]
  resources :users, only: [:show]
  resources :dynamic_objects
  resources :dynamic_object_types

end
