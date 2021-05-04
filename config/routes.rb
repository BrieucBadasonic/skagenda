Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :events, only: [ :index, :new, :create, :destroy ]

  resources :venues, only: [ :index ] do
    resources :events, only: [ :edit, :update ]
  end
end
