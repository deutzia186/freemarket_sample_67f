Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  root "items#index"
  resources :categories, only: :index, defaults: { format: 'json' }
  resources :items, only: [:index, :show, :new, :create]
  resources :users, only: [:index, :edit, :update]
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'

  resources :credit_card, only: [:new] do
    collection do
      get 'show', to: 'credit_card#show'
      post 'pay', to: 'credit_card#pay'
      post 'delete', to: 'credit_card#delete'
    end
  end

  resources :purchase, only: [:show] do
    member do
      post 'pay', to: 'purchase#pay'
      get 'done', to: 'purchase#done'
    end
  end
  
  end
end
