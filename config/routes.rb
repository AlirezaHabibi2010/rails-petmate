Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/bookings/:id/confirmation", to: "bookings#confirmation", as: "booking_confirmation"
  get "/bookings/requests_list", to: "bookings#requests_list"
  get "/inbox", to: "bookings#inbox"
  get "/bookings/:id/chatroom", to: "bookings#chatroom", as: "booking_chatroom"
  get "/pets/owner_requests_list", to: "pets#owner_requests_list"

  # Defines the root path route ("/")
  # root "articles#index"
  resources :bookmarks, only: :index
  resources :categories, only: %i[new create show]
  resources :pets, only: %i[index new create show]  do
    resources :bookmarks, only: [:create, :destroy]
    resources :bookings, only: %i[new create edit update]
  end

  resources :bookings, only: %i[show edit update] do
    resources :messages, only: %i[new create]
  end

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
