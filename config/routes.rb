Rails.application.routes.draw do
  get 'favorites/new'

  devise_for :users
  resources 'blogs'
  resources 'users', only: [:index, :show] do
    member do
      get 'favorites'
    end
  end

  resources :blogs do
    resource 'favorites', only: [:create, :destroy]
  end

  root 'blogs#index'
end
