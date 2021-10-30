Rails.application.routes.draw do
  namespace :providers do
    get 'purchases/index'
  end
  get 'admin/index'
  post 'admin/import'
  namespace :api do
    namespace :v1 do
      resources :clients, only: %w(index show)
      resources :providers, only: %w(index)
      resources :products, only: %w(index show)
      resources :orders, only: %w(create)
    end
  end
  resources :price_formulas do
    member do
      get 'toggle'
    end
  end
  resources :freights, only: %w(index)
  resources :reports, only: %w(index)
  resources :orders, only: %w(index show) do
    member do
      get 'toogle_delivered'
    end
  end
  resources :sale_point, only: :index
  resources :inventory, only: :index
  resources :products
  resources :product_brands
  resources :product_categories
  resources :providers do
    resources :provider_contacts 
  end
  resources :clients
  devise_for :users
  get 'home/index'
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, except: :destroy
end
