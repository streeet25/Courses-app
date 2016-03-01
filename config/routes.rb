Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: :index

  namespace :users do
  	resource  :profile, only: [:edit, :update], controller: :profile
    resources :courses
  end
end
