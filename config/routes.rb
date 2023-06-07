Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/bookings/:id/confirmation", to: "bookings#confirmation", as:"booking_confirmation"

  resources :categories, only: [:new, :create, :show]
  resources :pets, only: [:new, :create, :show]  do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, only: [:show, :edit, :update]
end
