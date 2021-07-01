Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'

  resources :events, only: %i[index new create destroy edit update] do
    collection do
      get :confirmation
    end
    member do
      put :confirmed
    end
  end
end
