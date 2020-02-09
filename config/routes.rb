Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations',
  }
  root "items#index"
  resources :categories, only: :index, defaults: { format: 'json' }
  resources :users, only: [:index, :edit, :update]
    resources :items, only: [:index, :show, :new, :edit, :destroy,:create] do
  #7つのデフォルトアクション以外のアクションを新しく追加したい場合
      collection do
        get 'get_category_children', defaults: { format: 'json' }
        get 'get_category_grandchildren', defaults: { format: 'json' }
      end
    end
  devise_scope :user do
    get 'addresses', to: 'users/registrations#new_address'
    post 'addresses', to: 'users/registrations#create_address'
  end
end
