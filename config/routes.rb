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

  put '/@:username', to: 'profiles#update'

  get '/@:username/channels', to: 'profiles#user_channels', as: :user_channels
  get '/@:username/subscriptions', to: 'profiles#user_subscriptions', as: :user_subs
  get '/@:username/about', to: 'profiles#about_user', as: :about_user
  get '/@:username/likes', to: 'profiles#user_likes', as: :user_likes
  get '/@:username/likes/comments', to: 'profiles#user_comment_likes', as: :user_comment_likes

  get '/channels/:id/channels', to: 'channels#owned_channels', as: :owned_channels
  get '/channels/:id/subscriptions', to: 'channels#channel_subscriptions', as: :channel_subs
  get '/channels/:id/about', to: 'channels#about_channel', as: :about_channel
  
  get '/channels/:channel_id/episodes/:id/related', to: 'episodes#related_episodes', as: :related_episodes
end
