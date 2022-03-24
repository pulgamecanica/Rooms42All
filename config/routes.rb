Rails.application.routes.draw do
  resources :reservations

  # get "reservations#index", to: "reservations#index"
  # get "reservations#new", to: "reservations#new"
  # get "reservations:id", to: "reservations#show"
  # get "reservations:id/edit", to: "reservations#edit"
  # post "reservations", to: "reservations#create"
  devise_for :admins
  resources :rooms
  get 'search_rooms', to: 'rooms#search_rooms'
  root to: 'rooms#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
