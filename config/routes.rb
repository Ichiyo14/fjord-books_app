Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users
  root to: 'books#index'
  resources :books
  resources :users, only: [:index, :show] do
    member do
      get :following, :followers
    end
    resources :relationships, only: [:create, :destroy]
  end
  resources :relationships, only: [:create, :destroy]
end
