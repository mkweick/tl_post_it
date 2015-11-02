PostitTemplate::Application.routes.draw do
  root to: 'posts#index'
  
  resources :posts do
    resources :comments, only: [:create, :edit, :update, :destroy]
  end
  resources :categories, only: [:show]
end