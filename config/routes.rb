Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: [:index] do
    resources :lessons, only: :index
    resources :participants, only: :index
    resource  :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
  end

  namespace :users do
    resource :blacklist, only: [:create, :destroy], controller: :course_bans
    resource  :profile, only: [:edit, :update], controller: :profile
    resources :participated_courses, only: :index, controller: :participated_courses
    resources :courses, except: [:show] do
      resources :lessons do
        resources :hometasks
      end
    end
  end
end
