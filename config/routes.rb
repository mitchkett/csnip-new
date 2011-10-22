CsnipNew::Application.routes.draw do
  devise_for :users
  resources :appointments do
    get 'print', :on => :collection
    get 'search', :on => :collection
    post 'print', :on => :collection
  end
  
  root :to => "appointments#index"
end
