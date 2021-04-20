Rails.application.routes.draw do
  devise_for :users
  devise_for :admins

  resources :subscriptions, only: %i[index new create show] do
    get 'search_course', on: :member
    resources :courses, only: [] do
      post 'add', on: :member
    end
  end
  
  resources :courses, only:[:new, :create, :index, :show]
  resources :orders, only:[:new, :create]
end
