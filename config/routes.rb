Rails.application.routes.draw do
  resources :heartbeats
  get 'jobs/index'
  get 'jobs/view'
  resources :contacts
  devise_for :users
  resources :probes
  resources :bilges
  root 'dashboard#main'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
