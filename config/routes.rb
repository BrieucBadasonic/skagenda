Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :events, only: [ :index, :new, :create, :destroy ] do
    collection do
      get :confirmation
    end
    member do
      put :confirmed
    end
  end

  resources :venues, only: [ :index ] do
    resources :events, only: [ :edit, :update ]
  end
end
