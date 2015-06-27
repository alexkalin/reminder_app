Rails.application.routes.draw do
  devise_for :users
  root 'homepage#index'
  
  namespace :account do
    resources :events
    resources :plans, only: [:index] do
      member do
        patch :switch
      end
    end
    resources :credit_cards, only: [:new, :create]

    scope :settings, controller: :settings do
      get :edit
      patch :update
    end
  end
end
