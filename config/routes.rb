Rails.application.routes.draw do
  devise_for :candidates, :controllers => {:registrations => "registrations"}
  devise_for :headhunters
  
  root to: 'home#index'
  resources :candidate_profiles, only: [:new, :create, :edit, :show, :update]
  resources :jobs, only: [:index, :new, :create, :show,  :edit, :update] do
    get 'search', on: :collection
    get 'apply_for', on: :member
    post 'confirm_application_for', on: :member
  end
  resources :job_applications, only: [:index, :show, :edit, :update, :delete] do
    get 'decline', on: :member
    post 'confirm_declination_for', on: :member
  end
end
