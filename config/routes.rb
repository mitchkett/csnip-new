CsnipNew::Application.routes.draw do
  devise_for :users
  resources :appointments
end
