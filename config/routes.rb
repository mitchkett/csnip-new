CsnipNew::Application.routes.draw do
  devise_for :users
  resources :appointments do
    get 'search', :on => :collection
    post 'print', :on => :collection
    put 'approve', :on => :member
    put 'deny', :on => :member
  end
  
  root :to => "appointments#index"
end
