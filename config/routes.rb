Celine::Application.routes.draw do |map|
  namespace :admin do |admin|
    # admin.resources :customers
    root :to => "main#index"
  end
  
  match 'login' => 'user_sessions#create'
  match 'logout' => 'user_sessions#destroy'
  match 'signup' => 'users#create'
  match 'reset_password' => 'password_resets#new'
  
  
  
  resource :account, :controller => "users"
  resource :user_sessions do
    collection do
      get 'create_with_fb'
    end
  end
  

  resources :password_resets
  resources :users
  
  #root :to => "users#new"
  root :to => "main#index"
end
