Rails.application.routes.draw do
  resources :reservations
  devise_for :admins
  resources :rooms
  get 'search_rooms', to: 'rooms#search_rooms'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
