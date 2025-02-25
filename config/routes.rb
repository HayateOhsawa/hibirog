Rails.application.routes.draw do
  devise_for :users
  root "records#index"
  resources :records do
    resources :comments, only: [:create, :destroy]
<<<<<<< Updated upstream
=======
    post :share, to: 'records#share', on: :member # on: :member でレコードIDがURLに含まれる
    post :add_tag, to: 'records#add_tag', on: :member
>>>>>>> Stashed changes
  end
  resources :chats, only: [:index, :create, :destroy]
  resources :records do
    post :share, to: 'records#share', on: :member # on: :member でレコードIDがURLに含まれる
  end
end
