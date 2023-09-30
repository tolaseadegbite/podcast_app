Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"

  resources :channels do
    resources :episodes do
      resources :comments do
        resources :comments
      end
    end
    resources :playlists
  end

  # resources :comments do
  #   resources :comments
  # end

  resources :tags, only: :create
  resources :likes, only: [:create, :destroy]
  resources :subscriptions, only: [:create, :destroy]
  resources :playlists
  
  get '/@:username', to: 'profiles#show', as: :profile
  get '/@:username/edit', to: 'profiles#update', as: :edit_profile

  get 'channels/:id/channels', to: 'channels#owned_channels', as: :owned_channels
  get 'channels/:id/subscriptions', to: 'channels#channel_subscriptions', as: :channel_subs
  get 'channels/:id/about', to: 'channels#about_channel', as: :about_channel
end
