PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  
  resources :posts do #, only: [:index, :create, :new, :edit, :show, :update]
    resources :comments, only: [:create]
  end
  resources :categories
end