Rails.application.routes.draw do
  devise_for :users
  root "records#index"
  get 'chats', to: 'chats#index'
  resources :records
  resources :chats, only: [:index, :new, :create, :destroy]
end
