Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  root "items#index"
  resources :categories, only: :index, defaults: { format: 'json' }
  resources :items, only: [:index, :show, :new, :create, :edit, :update, :destroy]
  resources :users, only: [:index, :edit, :show]
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
end
