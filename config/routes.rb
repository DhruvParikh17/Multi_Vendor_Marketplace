# config/routes.rb
# Tells the server where to send incoming web requests.
Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :stores, only: [:create, :show, :index] do
        resources :products, only: [:create, :index]
        resources :orders, only: [:create]
      end
    end
  end
end