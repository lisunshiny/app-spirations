Rails.application.routes.draw do
  resources :users, except: [:destroy]
  resource :session, only: [:new, :create, :destroy]
  resources :goals, except: [:destroy]

  root 'goals#index'


end
