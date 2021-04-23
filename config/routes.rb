Rails.application.routes.draw do
  devise_for :users
  as :user do
    get 'user', to: 'user#show', as: :user_profile
    get 'user/subscriptions', to: 'user#subscriptions', as: :user_subscriptions
    get 'user/courses', to: 'user#courses', as: :user_courses
    get 'user/orders', to: 'user#orders', as: :user_orders
  end

  devise_for :admins
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :subscriptions, only: %i[index new create show] do
    get 'search_course', on: :member
    resources :courses, only: [] do
      post 'add', on: :member
    end
  end

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
