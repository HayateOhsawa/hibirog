Rails.application.routes.draw do
  devise_for :users
  get 'chats/index'
  get 'records/index'
  root "records#index"
  resources :records, only: [:index, :new, :create, :show]
end
