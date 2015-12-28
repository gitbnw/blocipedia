Rails.application.routes.draw do

  resources :wikis

  resources :charges, only: [:new, :create]

  resources :users

  get 'about' => 'welcome#about'

  devise_for :users

  root 'welcome#index'

end
