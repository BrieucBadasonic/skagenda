Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :events, only: [ :index, :new, :create, :edit, :update, :destroy ] do
    resources :venue, only: [ :new, :create, :edit, :update]
  end
end
