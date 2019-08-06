Rails.application.routes.draw do
  root to: 'users#new'
  resources :users, only: [:index, :show, :new, :create]
  resource :profile, only: [:show, :edit, :update, :destroy]
  get '/login',  to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
end
