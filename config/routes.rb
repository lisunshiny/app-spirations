Rails.application.routes.draw do
  resources :users, except: [:destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :goals, only: [:show, :index, :create, :new, :edit, :update]

  root 'goals#index'


end
