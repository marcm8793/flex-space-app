Rails.application.routes.draw do
  get 'maps/show'
  devise_for :users
  resource :user, only: [:edit, :update]

  root to: "places#index"
    get '/trip', to: 'trips#index'

  get "up" => "rails/health#show", as: :rails_health_check
  resources :places do
    resources :bookings
    post "favorite", to: "favorites#create"
    delete "favorite", to: "favorites#destroy"
  end

  get 'map', to: 'maps#show'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.

  # Defines the root path route ("/")
  # root "posts#index"
end
