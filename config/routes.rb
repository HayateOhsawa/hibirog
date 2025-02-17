Rails.application.routes.draw do
  devise_for :users
  root "records#index"
  resources :records
  resources :chats, only: [:index, :create, :destroy]
  resources :records do
    post :share, to: 'records#share', on: :member # on: :member でレコードIDがURLに含まれる
  end
end
