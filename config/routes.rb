Rails.application.routes.draw do

  resources :wikis

  resources :charges, only: [:new, :create]

  resources :users, only: [:update, :show]

  get 'about' => 'welcome#about'
  
  devise_for :users, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  root 'welcome#index'

end
