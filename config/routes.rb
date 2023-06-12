Rails.application.routes.draw do
  devise_for :users

  root to: "pages#home"
  get "/profile", to: "pages#profile"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "/bookings/requests_list", to: "bookings#requests_list"
  get "/pets/owner_requests_list", to: "pets#owner_requests_list"
  get "/pets/list", to: "pets#list"
  get "/inbox", to: "bookings#inbox"

  # Defines the root path route ("/")
  # root "articles#index"
<<<<<<< HEAD
  resources :bookmarks, only: [:index, :destroy]
  resources :categories, only: %i[new create show]
=======
  resources :bookmarks, only: :index
  resources :categories, except: [:destroy]
>>>>>>> 7aae9612abc320d2d287d399b7a51c3875969646
  resources :pets, only: %i[index new create show list]  do
    member do
      patch  :deactivate
    end
    resources :bookings, only: %i[new create edit update]
    resources :bookmarks, only: %i[create]
  end

  resources :bookings, only: %i[show edit update] do
    member do
      patch  :deactivate
      patch  :accepted
      patch  :ongoing
      patch  :completed
      patch  :declined
      get    :chatroom
      get    :confirmation
    end
    resources :messages, only: %i[new create]
  end

  require "sidekiq/web"
  authenticate :user, ->(user) { user.admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end
end
