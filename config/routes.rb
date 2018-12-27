Rails.application.routes.draw do
  get 'jobs/index'
  get 'jobs/view'
  resources :contacts
  devise_for :users
  resources :probes
  resources :bilges
  root 'bilges#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
