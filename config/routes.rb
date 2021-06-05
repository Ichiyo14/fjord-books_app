Rails.application.routes.draw do
  # routesは上から読まれる

  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :users, only: [:show, :index]
  resources :books
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
end
