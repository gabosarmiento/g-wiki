GWiki::Application.routes.draw do

  get "wikis/basic" => "content#basic", :as => :content_basic
  get "wikis/pro" => "content#pro", :as => :content_pro
  authenticated :user do
    root :to => 'welcome#index'
  end
  root to: 'welcome#index'
  get 'tags/:tag', to: 'wikis#index', as: :tag
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
    
  match "versions/:id/revert" => "versions#revert", via: :post, :as => "revert_version"
  match "versions/:id/uncreate" => "versions#uncreate", via: :post, :as => "uncreate_version"

  match 'contact' => 'contact#new', :as => 'support', :via => :get
  match 'contact' => 'contact#create', :as => 'support', :via => :post

  match "about" => 'welcome#about', via: :get
  
  

end
