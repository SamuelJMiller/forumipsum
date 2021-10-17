Rails.application.routes.draw do
  resources :posts
  devise_for :users, :controllers => {
    registrations: 'users/registrations'
  }
  resources :forumthreads
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'forumthreads#index'
end
