Rails.application.routes.draw do
  devise_for :users, path_prefix: "account"
  resources :users

  root "welcome#index"
  get "/search" => "dynamic_objects#search"
  get "/location" => "users#location"

  resources :connections, only: [:create, :destroy]

  resources :dynamic_objects
  resources :dynamic_object_types
end
