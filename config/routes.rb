Rails.application.routes.draw do
  get 'edit_histories/index'
  #get 'home/index'
  devise_for :users
  root "home#index"
  
  # カレンダーのルート
  get 'calendar', to: 'events#calendar'

  # ユーザー関連のルート
  resources :users, only: [:edit, :update, :destroy]

  # ショッピングリストのルート
  resources :shopping_lists, only: [:index, :create, :new, :show, :edit, :update, :destroy] do
    collection do
      get :show_by_date  # 日付ごとのリストを表示するルート
      get :today
    end

    # アイテムの追加ルート（shopping_list_idを受け取る）
    resources :items, only: [:create, :destroy, :update, :edit]
  end

  resources :plans do
    collection do
      get :today
    end
  end

  resources :edit_histories, only: [:index]

  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
