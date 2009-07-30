ActionController::Routing::Routes.draw do |map|
  map.resources :companies, :has_many => [:users]
  map.resources :users
  map.resources :roles
  map.resources :files, :collection => {:download => :get, :show_download => :get}
  map.resources :service, :collection => {:thank_you => :get, :get_access => :get}, :member => {:external_edit => :get}

  map.resource :user_session
  map.resource :roles

  map.root :controller => "users"
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy'
  map.register 'register', :controller => 'users', :action => 'new'

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
