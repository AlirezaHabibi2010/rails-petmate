Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/bookings/requests_list", to: "bookings#requests_list"
  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, only: [:new, :create, :show]
  resources :pets, only: [:new, :create, :show]
end
