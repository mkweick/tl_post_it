PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  
  get '/register', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  
  resources :users, only: [:create, :show, :edit, :update]
  resources :categories, only: [:show]
  
  resources :posts do
    member do
      post '/vote', to: 'posts#vote'
    end
    
    resources :comments, only: [:create, :edit, :update, :destroy] do
      member do
        post '/vote', to: 'comments#vote'
      end
    end
  end
end