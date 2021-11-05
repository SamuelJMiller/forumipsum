Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords: 'users/passwords',
    unlocks: 'users/unlocks'
  }

  match '/users',     to: 'users#index', via: 'get'
  match '/users/:id', to: 'users#show',  via: 'get'

  resources :users, :only => [:show]

  resources :forumthreads do
    resources :posts
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'forumthreads#index'
end
