Rails.application.routes.draw do
  resources :price_formulas
  resources :sale_point, only: :index
  resources :inventory, only: :index
  resources :products
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
