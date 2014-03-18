GWiki::Application.routes.draw do

  get "wikis/basic" => "content#basic", :as => :content_basic
  get "wikis/pro" => "content#pro", :as => :content_pro

  resources :sales

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }
  resources :users, only: [:show]
  resources :wikis do
    resources :collaborations, only: [:index, :new, :create, :destroy]
    end
    
  resources :my_wikis, only: [:index, :show]
  resources :charges, only: [:new, :create]

  match "about" => 'welcome#about', via: :get
  match "support" => 'welcome#support', via: :get
  root to: 'welcome#index'

end
