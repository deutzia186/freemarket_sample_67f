Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :categories, only: :index, defaults: { format: 'json' }

end
