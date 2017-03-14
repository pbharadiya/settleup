Rails.application.routes.draw do
  root to: 'static_pages#home'
  devise_for :users
  resources :groups do
    resources :payments, except: [:index]
  end
end
