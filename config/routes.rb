Rails.application.routes.draw do
  devise_for :users
  devise_for :admins

  resources :subscriptions, only: %i[index new create show] do
    get 'search_course', on: :member
    resources :courses, only: [] do
      post 'add', on: :member
    end
  end
  
  root 'home#index'

  namespace :admins do
    root 'dashboard#index'
    resources :courses, only: [:index, :show] do
      resources :lessons, only: [:show, :new, :create, :edit, :update, :destroy]
    end
  end

  resources :courses, only:[:index, :show] do
    resources :lessons, only: [:show]
  end
  resources :orders, only:[:new, :create]
end
