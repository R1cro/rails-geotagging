Rails.application.routes.draw do
  devise_for :users, path_prefix: "account"
  resources :users

  root "welcome#index"
  get "/search" => "dynamic_objects#search"

  resources :connections, only: [:create, :destroy]

  resources :dynamic_objects do
    collection do
      get "search"
    end
  end

  namespace :api, defaults: { format: :json } do
    resources :dynamic_objects do
      collection do
        get "search"
      end
    end
  end
end
