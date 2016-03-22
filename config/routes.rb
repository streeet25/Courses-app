Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: [:index, :show] do
    resources :participants, only: :index
    resource  :subscriptions, only: [:create, :destroy], controller: :course_subscriptions
  end

  namespace :users do
    resource :blacklist, only: [:ban, :unban], controller: :course_members do
      patch :ban, on: :member
      patch :unban, on: :member
    end
    resource  :profile, only: [:edit, :update], controller: :profile
    resources :participated_courses, only: :index, controller: :participated_courses
    resources :courses do
      resources :lessons, except: :index do
        resources :hometasks
      end
    end
  end
end
