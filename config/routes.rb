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

  root 'home#index'

  namespace :admin do
    root 'dashboard#index'
    resources :subscriptions, only: [:index, :show, :new, :create] do
      post 'add_course', on: :member
      get 'search_course', on: :member
      resources :courses, only: [] do
      end
    end
    resources :courses, only: [:new, :create, :index, :show] do
      resources :lessons, only: [:show, :new, :create, :edit, :update, :destroy]
    end
    resources :members
  end

  resources :subscriptions, only: %i[index show]
  resources :courses, only:[:index, :show] do
    resources :lessons, only: [:show] do
      post 'check_done',  on: :member
      post 'uncheck_done', on: :member
    end
  end
  resources :orders, only:[:new, :create]
end
