Rails.application.routes.draw do
  devise_for :users, path_prefix: "account"
  resources :users

  root "welcome#index"

  resources :connections, only: [:create, :destroy]
  resources :dynamic_objects do
    collection do
      get "search"
    end
  end
  resources :dynamic_object_types

  namespace :api, defaults: { format: :json } do
    resources :dynamic_objects do
      collection do
        get "search"
      end
    end
  end
end
