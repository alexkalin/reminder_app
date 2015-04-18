Rails.application.routes.draw do
  devise_for :users
  root 'homepage#index'
  
  namespace :account do
    resources :events
  end
end
