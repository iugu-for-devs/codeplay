Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, only: [:sessions], module: :admins

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  # resources :coursers, only: %i[index view]

  namespace :admins do
    root 'dashboard#index'
    resources :members
    # resources :coursers
  end
end
