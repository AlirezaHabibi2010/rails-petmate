Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/bookings/:id/confirmation", to: "bookings#confirmation", as:"booking_confirmation"
  get "/bookings/requests_list", to: "bookings#requests_list"
  get "/pets/owner_requests_list", to: "pets#owner_requests_list"
  # Defines the root path route ("/")
  # root "articles#index"
  resources :categories, only: [:new, :create, :show]
  resources :pets, only: [:index, :new, :create, :show]  do
    resources :bookings, only: [:new, :create, :edit, :update]
  end

  resources :bookings, only: [:show]
end
