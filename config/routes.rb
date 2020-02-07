Rails.application.routes.draw do
  devise_for :users
  root "items#index"
  resources :categories, only: :index, defaults: { format: 'json' }
    resources :items, only: [:index, :show, :new, :edit, :destroy] do
  #7つのデフォルトアクション以外のアクションを新しく追加したい場合
      collection do
        get 'get_category_children', defaults: { format: 'json' }
        get 'get_category_grandchildren', defaults: { format: 'json' }
      end
    end
end
