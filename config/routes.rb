Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"

  resources :channels do
    resources :episodes
  end

  resources :tags, only: :create
  resources :likes, only: [:create, :destroy]
  resources :subscriptions, only: [:create, :destroy]
  resources :playlists
  
  get '/:username', to: 'profiles#show', as: :profile
  get '/:username/edit', to: 'profiles#update', as: :edit_profile

end
