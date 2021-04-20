Rails.application.routes.draw do
  devise_for :users
  devise_for :admins

  root 'home#index'

  namespace :admins do
    root 'dashboard#index'
    resources :subscriptions, only: [:index, :show, :new, :create] do
      get 'search_course', on: :member
      resources :courses, only: [] do
        post 'add', on: :member
      end
    end
    resources :courses, only: [:index, :show] do
      resources :lessons, only: [:show, :new, :create, :edit, :update, :destroy]
    end
  end

  
  resources :subscriptions, only: %i[new create] do
    
    
  end

  resources :courses, only:[:index, :show] do
    resources :lessons, only: [:show]
  end
  
  resources :orders, only:[:new, :create]
end
