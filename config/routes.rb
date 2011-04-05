Celine::Application.routes.draw do |map|
  namespace :admin do |admin|
    # admin.resources :customers
    root :to => "main#index"
  end
  
  map.signup 'signup', :controller => "users", :action => "new"
  map.login 'login', :controller => 'user_sessions', :action => 'new'
  map.logout 'logout', :controller => 'user_sessions', :action => 'destroy' 
  map.reset_password 'reset_password', :controller => 'password_resets', :action => 'new'
  
  map.resource :user_session
  map.resource :account, :controller => "users"
  

  map.resources :password_resets
  map.resources :users
  
  #root :to => "users#new"
  root :to => "main#index"
end
