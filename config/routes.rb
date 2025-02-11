Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  ##get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  # Root â€“ if not authenticated, Sessions#new (login)
  root to: "sessions#new"
  
  # Sessions for login/logout
  get    '/login',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  # User registration and account update
  resources :users, only: [:new, :create] # This automatically creates users_path for form_with
  get  '/signup',       to: 'users#new'
  post "/signup", to: "users#create"
  #post '/users',        to: 'users#create'
  get  '/account',      to: 'users#edit'
  patch '/account',     to: 'users#update'
  
  # Password reset routes
  resources :password_resets, only: [:new, :create, :edit, :update]

  get  '/password_reset', to: 'password_resets#new'
  post '/password_reset', to: 'password_resets#create'
  get  '/password_reset/edit', to: 'password_resets#edit'
  patch '/password_reset',     to: 'password_resets#update'
  
  # Thoughts (feed)
  resources :thoughts, only: %i[index create destroy]
  mount ActionCable.server => '/cable'
  get '/manifest.json', to: ->(_) { [200, { "Content-Type" => "application/json" }, [File.read(Rails.root.join("public", "manifest.json"))]] }

  # Friends management â€“ listing, requests, etc.
  resources :friends, only: [:index] do
    collection do
      post 'add'
      post 'accept'
      post 'reject'
    end
  end

  #resources :thoughts do
    #resources :comments, only: [:create]
    #post 'toggle_like', to: 'likes#toggle_like'
  #end

  resources :thoughts do
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

  
  #root "home#index" # Or your homepage controller


end


