# == Route Map
#

Rails.application.routes.draw do
  devise_for :users, controllers:{
    sessions: "users/sessions",
    registrations: "users/registrations"
  }


  resources :offers do
    member do
      post 'postular' # Esto crea postular_offer_path
    end
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.


  devise_scope :user do
    get "admin/login", to: "users/sessions#new", as: :new_admin_session
    get "admin/sign_up", to: "users/registrations#new", as: :new_admin_registration
  end




  namespace :admin do
    resources :users, only: [:new, :create]
  end

# Esto generará automáticamente las rutas RESTful para index, show, new, create, edit, update y destroy.
  resources :offers do
    post :request, on: :member
  end
    
    

  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest





  # Defines the root path route ("/")
  root "offers#index"
end
