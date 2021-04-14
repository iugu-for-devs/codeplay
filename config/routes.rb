Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  
  root 'home#index'

  resources :courses, only: [:index, :show]
  resources :lessons, only: [:show]
end
