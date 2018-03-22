Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'

  namespace :admin do
    root 'admin_home#index'
    resources :admin
    resources :tournaments do
      resources :players
    end
  end
end
