Rails.application.routes.draw do
  root to: 'courses#index'

  devise_for :users, controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  resources :courses, only: [:index, :show] do
    resources :participants, only: :index
    resource  :subscriptions, only: [:update, :destroy], controller: :course_subscriptions
    resource :kick, only: [:update], controller: :course_kick
  end

  namespace :users do
    resource  :profile, only: [:edit, :update], controller: :profile
    resources :courses do
      resources :lessons, except: :index do
        resources :hometasks, except: :index
      end
    end
  end
end
