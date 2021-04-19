Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  resources :courses, only:[:new, :create, :index, :show]
  resources :orders, only:[:new, :create]
end
