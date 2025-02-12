Rails.application.routes.draw do
  # Root route (login page if not authenticated)
  root to: "sessions#new"
  
  # Authentication routes
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  delete '/logout_all', to: 'users#destroy_all_sessions', as: 'logout_all'

  get '/dashboard', to: 'dashboard#index'

  
  # User registration
  resources :users, only: [:show, :new, :create]
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  
  # Account management
  resource :account, controller: "users", only: [:show, :edit, :update]
  get  '/account',  to: 'users#edit'
  patch '/account', to: 'users#update'
  
  # Password reset
  resources :password_resets, only: [:new, :create, :edit, :update]
  get  '/password_reset',        to: 'password_resets#new'
  post '/password_reset',        to: 'password_resets#create'
  get  '/password_reset/edit',   to: 'password_resets#edit'
  patch '/password_reset',       to: 'password_resets#update'
  
  # Thoughts (posts)
  resources :thoughts, only: %i[index create show edit update destroy] do
    member do
      post 'like'
    end
    resources :comments, only: [:create]
  end
  
  resources :comments, only: [] do
    member do
      post 'like'
    end
  end

  # ActionCable for real-time updates
  mount ActionCable.server => '/cable'

  # PWA manifest
  get '/manifest.json', to: ->(_) { [200, { "Content-Type" => "application/json" }, [File.read(Rails.root.join("public", "manifest.json"))]] }

  # Friends management
  resources :friends, only: [:index] do
    member do
      post 'add'
      post 'accept'
      delete 'reject'
    end
  end
end
