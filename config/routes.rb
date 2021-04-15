Rails.application.routes.draw do
  devise_for :users
  devise_for :admins, only: %i[sessions registrations passwords], controllers: {
    sessions: 'admins/sessions',
    registrations: 'admins/registrations',
    passwords: 'admins/passwords'
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  namespace :admins do
    root 'home#index'
  end
  
end
