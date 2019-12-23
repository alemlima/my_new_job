Rails.application.routes.draw do
  devise_for :candidates, :controllers => {:registrations => "registrations"}
  devise_for :headhunters
  
  root to: 'home#index'
  resources :jobs, only: [:index, :new, :create, :show,  :edit, :update]
  resources :candidate_profiles, only: [:new, :create, :edit, :show, :update]
end
