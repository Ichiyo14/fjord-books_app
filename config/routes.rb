Rails.application.routes.draw do
  # routesは上から読まれる

  devise_for :users
  resources :users, only: [:show, :index]
  resources :books
  as :user do
    get 'books', :to => 'books#index', :as => :user_root
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
