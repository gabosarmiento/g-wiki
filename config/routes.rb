GWiki::Application.routes.draw do

  resources :sales

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  resources :users, only: [:show]
  resources :wikis

  resources :charges, only: [:new, :create]

  match "about" => 'welcome#about', via: :get
  match "support" => 'welcome#support', via: :get
  resources :my_wikis, only: [:index, :show]

  root to: 'welcome#index'

end
