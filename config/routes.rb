CsnipNew::Application.routes.draw do
  devise_for :users
  resources :appointments
  
  root :to => "appointments#index"
end
