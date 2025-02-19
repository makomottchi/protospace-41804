Rails.application.routes.draw do
  devise_for :users
  get 'prototypes/index'
  

  root to: "prototypes#index"


  resources :prototypes, only: [:index, :create, :new, :show,:edit,:update,:destroy]
  resources :users, only: [:show]
  resources :prototypes do
    resources :comments, only: [:create]
  end

end
