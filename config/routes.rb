Rails.application.routes.draw do
  devise_for :users
  root "records#index"
  resources :records do
    resources :comments, only: [:create, :destroy]
    post :share, to: 'records#share', on: :member # on: :member でレコードIDがURLに含まれる
<<<<<<< Updated upstream
    post :add_tag, to: 'records#add_tag', on: :member
=======
>>>>>>> Stashed changes
  end
  resources :chats, only: [:index, :create, :destroy]
end
