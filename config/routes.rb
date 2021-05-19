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


  resources :events, only: [ :edit, :update ] do
    resources :venues, only: [ :index ]
  end

  resources :venues, only: [ :update ]
end
