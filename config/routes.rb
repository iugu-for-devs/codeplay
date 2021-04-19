Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  resources :subscriptions, only: %i[index new create show] do
    get 'search_course', on: :member    
    post 'add_course', on: :member
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
