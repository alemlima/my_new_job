Rails.application.routes.draw do
  devise_for :candidates, :controllers => {:registrations => "registrations"}
  devise_for :headhunters
  
  root to: 'home#index'
  resources :candidate_profiles, only: [:new, :create, :edit, :show, :update]
  resources :jobs, only: [:index, :new, :create, :show,  :edit, :update] do
    get 'search', on: :collection
  end
end
