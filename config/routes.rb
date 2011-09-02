Sn::Application.routes.draw do

  resources :photos

  resources :albums

  root :to => 'application#home'

  devise_for :users, :path_names => { :registration => :register }

  resources :users do
    get '/daily_stats', :on => :collection
    get '/search', :on => :collection
    resources :wall_messages, :only => [:index, :create]
    resources :contacts, :only => :index do
      get '/pending', :action => :index_pending, :as => :pending, :on => :collection
    end
    resources :albums, :only => :index
  end

  resources :contacts, :only => :destroy do
    member do
      post '/', :action => :accept
      put '/', :action => :propose
    end
  end

  resources :photos, :only => [:edit, :update, :destroy]

  resources :albums, :except => [:new, :edit, :update] do
    resources :photos, :only => [:new, :create]
  end

  resources :profiles, :only => [:show, :edit, :update] do
    post '/status', :action => :update_status, :as => :status
  end

end
