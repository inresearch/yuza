Rails.application.routes.draw do
  resources :users, only: [:create, :update, :show]

  resources :sessions, only: [:create] do
    member do
      get :verify
    end
  end
end
