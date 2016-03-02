Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: :index do
  	resources :participants, only: :index
  	resource  :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
  end

  namespace :users do
  	resource  :profile, only: [:edit, :update], controller: :profile
    resources :courses
  end
end
