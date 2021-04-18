Rails.application.routes.draw do
  devise_for :users
  devise_for :admins

  root 'home#index'

  namespace :admins do
    root 'dashboard#index'
    resources :courses, only: [:index, :show], shallow: true do
      resources :lessons, only: [:show, :new, :create, :edit, :update, :destroy]
    end
  end
end