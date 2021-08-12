Rails.application.routes.draw do
  resources :product_brands
  resources :product_categories
  resources :providers
  resources :clients
  devise_for :users
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, except: :destroy
end
