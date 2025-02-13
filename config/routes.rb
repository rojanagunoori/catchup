Rails.application.routes.draw do
 # devise_for :users
  #devise_for :users, skip: [:registrations]

  # Root route (login page if not authenticated)
  root to: "sessions#new"
  #root to: "home#index"

  
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

  #resources :friend_requests, only: [:create, :destroy] 
  resources :friend_requests, only: [:create, :destroy] do
    member do
      patch :accept  # This enables the accept action
      delete :reject # Route for rejecting requests
    end
  end
  


  accept_friend_path  POST  /friends/:id/accept(.:format)  friends#accept


  # ActionCable for real-time updates
  mount ActionCable.server => '/cable'

  # PWA manifest
   get '/manifest.json', to: ->(_) { [200, { "Content-Type" => "application/json" }, [File.read(Rails.root.join("public", "manifest.json"))]] }

  # Friends management
    resources :friends, only: [:index] do
    get :search, on: :collection
    member do
      post 'add'#, on: :member    # Generates /friends/:id/add
      post 'accept'#, on: :member # Generates /friends/:id/accept
      delete 'reject'#, on: :member # Generates /friends/:id/reject
    end
  end
end
