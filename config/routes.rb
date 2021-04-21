Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  root 'home#index'

  namespace :admin do
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
    resources :members
  end

  resources :subscriptions, only: %i[index show]
  resources :courses, only:[:index, :show] do
    resources :lessons, only: [:show]
  end

  resources :orders, only:[:new, :create]
end
