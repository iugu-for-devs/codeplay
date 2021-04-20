Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  namespace :admin do
    root 'dashboard#index'
    resources :courses, only: [:index, :show] do
      resources :lessons, only: [:show, :new, :create, :edit, :update, :destroy]
    end
    resources :members
  end

  resources :courses, only:[:new, :create, :index, :show]
  resources :orders, only:[:new, :create]
end
