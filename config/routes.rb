Rails.application.routes.draw do
  #get 'home/index'
  devise_for :users
  root "home#index"
  get 'calendar', to: 'events#calendar'

  resources :users, only: [:edit, :update, :index]

  resources :shopping_lists, only: [] do
    collection do
      get :show_by_date
    end
  end

  resources :shopping_lists do
    collection do
      get :show_by_date
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
