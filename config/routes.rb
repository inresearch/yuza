Rails.application.routes.draw do
  resources :users, only: [:create, :update, :show]

  resources :sessions, only: [:create, :show], param: :code do
    member do
      delete :revoke
    end
  end
end
