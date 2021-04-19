Rails.application.routes.draw do
  devise_for :users
  devise_for :admins
  resources :courses, only: %i[new create index show]
end
