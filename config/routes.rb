Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  resources :courses, only:[:show]
  resources :orders, only:[:new, :create]
end
