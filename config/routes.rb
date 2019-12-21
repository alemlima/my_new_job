Rails.application.routes.draw do
  devise_for :candidates
  devise_for :headhunters
  
  root to: 'home#index'
  resources :jobs, only: [:index, :show, :new, :create]
  resources :candidate_profiles, only: [:new, :create, :edit, :show, :update]
end
