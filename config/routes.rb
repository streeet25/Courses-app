Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: [:index, :show] do
    resources :participants, only: :index
    resource  :subscriptions, only: [:update, :destroy], controller: :course_subscriptions do
      patch :kick, on: :member
    end
  end

  namespace :users do
    resource  :profile, only: [:edit, :update], controller: :profile
    resources :courses do
      resources :lessons, except: :index do
        resources :hometasks
      end
    end
  end
end
