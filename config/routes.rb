Rails.application.routes.draw do
  devise_for :users
  root "static_pages#home"

  resources :channels

  get '/:username', to: 'profiles#show', as: :profile
  get '/:username/edit', to: 'profiles#update', as: :edit_profile
end
