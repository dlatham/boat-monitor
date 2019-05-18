Rails.application.routes.draw do
  get 'heartbeats/get_count', to: 'heartbeats#get_count'
  post 'heartbeats/destroy_before', to: 'heartbeats#destroy_before'
  resources :heartbeats
  get 'jobs/index'
  get 'jobs/view'
  resources :contacts
  devise_for :users
  resources :probes
  resources :bilges
  resources :light_controllers do
    get 'config', to: 'light_controllers#get_controller_config' 
    get 'status', to: 'light_controllers#get_controller_status'   
  end
  root 'dashboard#main'
  resources :settings, only: [:index] do
  	
  end
  post 'settings/set_device_id', to: 'settings#set_device_id'
  post 'settings/store_local_config', to: 'settings#store_local_config'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
