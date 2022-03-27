Rails.application.routes.draw do
  devise_for :admins
  # get "reservations#index", to: "reservations#index"
  # get "reservations#new", to: "reservations#new"
  # get "reservations:id", to: "reservations#show"
  # get "reservations:id/edit", to: "reservations#edit"
  # post "reservations", to: "reservations#create"
  resources :rooms, only: [:index, :new, :edit, :update, :destroy]
  resources :reservations, only: [:index, :new, :edit, :update, :destroy]
  get 'search_rooms', to: 'rooms#search_rooms'
  get 'filter_reservations', to: 'reservations#filter_reservations'
  root to: 'rooms#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
