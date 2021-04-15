Rails.application.routes.draw do
  devise_for :users
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  namespace :admin do
    devise_for :admins 
    get 'admins', to: 'admins#index'
  end

end
