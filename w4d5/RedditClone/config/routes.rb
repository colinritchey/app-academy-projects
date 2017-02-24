Rails.application.routes.draw do
  root 'subs#index'

  resources :users
  resource :session

  resources :subs
  resources :posts
  end
