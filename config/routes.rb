Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'home#index'

  resources :users, only: :show
  resources :tournaments do
    resources :votes, only: :show do
      post 'sort', on: :member
    end
    resources :teams, only: %i[index edit update show]
    resources :players, only: :index
    resources :matches, only: %i[index show]
  end

  namespace :admin do
    root 'tournaments#index'
    resources :admin
    resources :tournaments do
      post 'done', on: :member
      resources :votes, only: :update
      resources :teams, except: :show do
        put 'generate_teams', on: :collection
        post 'update_teams', on: :collection
        get 'edit_teams', on: :collection
      end
      resources :players, only: %i[index new create destroy]
      resources :matches do
        put 'generate_matches', on: :collection
        post 'sort', on: :collection
      end
    end
  end
end
