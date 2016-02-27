Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users

  resources :courses, only: :index

  namespace :users do
    resources :courses
  end
end
