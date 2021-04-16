Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, module: :admins

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  namespace :admins do
    root 'dashboard#index'
  end
end
