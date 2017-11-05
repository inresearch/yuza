Rails.application.routes.draw do
  resources :users, only: [] do
    collection do
      get 'signin'
      get 'signup'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    resources :users, only: [:create, :update, :show]

    resources :sessions, only: [:create, :show], param: :code do
      member do
        delete :revoke
      end
    end # sessions

    resources :action_requests, only: [:create]
  end # api
end
