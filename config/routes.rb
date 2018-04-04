Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'

  resources :users, only: :show
  resources :tournaments do
    resources :votes, only: :show do
      post 'sort', on: :member
    end
    resources :teams, only: [:index, :edit, :update, :show]
    resources :players, only: [:index]
    resources :matches, only: [:index, :show]
  end

  namespace :admin do
    root 'admin_home#index'
    resources :admin
    resources :tournaments do
      post 'done', on: :member
      resources :votes, only: :update
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
        post 'sort', on: :collection
      end
    end
  end
end
