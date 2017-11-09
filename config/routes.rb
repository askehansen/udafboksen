Rails.application.routes.draw do

  root to: 'users#new'

  resources :users

  resources :telegram_updates, only: [:create]

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
