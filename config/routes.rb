Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'

  namespace :admin do
    root 'admin_home#index'
    resources :admin
    resources :tournaments do
      resources :teams, only: [:index, :new, :destroy] do
        put 'generate_teams', on: :collection
        put 'update_teams', on: :collection
        get 'edit_teams', on: :collection
      end
      resources :players, only: [:index, :new, :destroy] do
        put 'update_list_of_players', on: :collection
      end
      resources :matches do
        put 'generate_matches', on: :collection
        put 'generate_play_off', on: :collection
        post 'sort', on: :collection
      end
    end
  end
end
