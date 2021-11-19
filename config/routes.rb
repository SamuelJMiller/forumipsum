Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    unlocks:       'users/unlocks'
  }

  match '/users/:id/promote', to: 'users#promote_user', via: 'get', as: :promote_user
  match '/users/:id/demote',  to: 'users#demote_user',  via: 'get', as: :demote_user
  match '/users/:id',         to: 'users#show',         via: 'get'
  match '/users',             to: 'users#index',        via: 'get'

  resources :users, :only => [:show, :destroy]

  resources :forumthreads do
    resources :posts
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'forumthreads#index'
end
