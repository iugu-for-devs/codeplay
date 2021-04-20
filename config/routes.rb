Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  # resources :coursers, only: %i[index view]

  namespace :admin do
    root 'dashboard#index'
    resources :members
    # resources :coursers
  end
end
