GWiki::Application.routes.draw do

  get "wikis/basic" => "content#basic", :as => :content_basic
  get "wikis/pro" => "content#pro", :as => :content_pro
  authenticated :user do
    root :to => 'welcome#index'
  end
  root to: 'welcome#index'
  resources :sales
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'registrations' }
  devise_scope :user do
    put 'update_plan', :to => 'registrations#update_plan'
    put 'update_card', :to => 'registrations#update_card'
  end
  resources :users, only: [:show, :update]
  resources :wikis do
    resources :collaborations, only: [:index, :new, :create, :destroy]
    end
    
  resources :my_wikis, only: [:index, :show]
  resources :charges, only: [:new, :create]

  match "about" => 'welcome#about', via: :get
  match "support" => 'welcome#support', via: :get
  

end
