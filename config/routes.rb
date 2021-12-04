Rails.application.routes.draw do
  devise_for :users, :controllers => {
    registrations: 'users/registrations',
    confirmations: 'users/confirmations',
    passwords:     'users/passwords',
    unlocks:       'users/unlocks'
  }

  match '/users/:id/image',     to: 'users#update_image',     via: 'patch', as: :update_user_image
  match '/users/:id/signature', to: 'users#update_signature', via: 'patch', as: :update_user_sig
  match '/users/:id/promote',   to: 'users#promote_user',     via: 'get',   as: :promote_user
  match '/users/:id/demote',    to: 'users#demote_user',      via: 'get',   as: :demote_user
  match '/users/:id/unban',     to: 'users#unban_user',       via: 'get',   as: :unban_user
  match '/users/:id',           to: 'users#show',             via: 'get'
  match '/users',               to: 'users#index',            via: 'get'

  resources :users, :only => [:show, :destroy]

  resources :forumthreads do
    resources :posts
  end

  match '/forumthreads/:forumthread_id/posts/:id/report', via: 'get', to: 'posts#report', as: :report_post
  match '/forumthreads/:forumthread_id/posts/:id/reset_reports', via: 'get', to: 'posts#reset_reports',
        as: :post_reset_reports
  match '/forumthreads/:id/report', via: 'get', to: 'forumthreads#report', as: :report_forumthread
  match '/forumthreads/:id/reset_reports', via: 'get', to: 'forumthreads#reset_reports',
        as: :forumthread_reset_reports

  match '/admin', to: 'admin#index', via: 'get', as: :admin

  match '/categories/new', to: 'categories#new',    via: 'get', as: :new_category
  match '/categories',     to: 'categories#create', via: 'post'
  match '/categories',     to: 'categories#create', via: 'patch'

  match '/:category_id/forumthreads/new', to: 'forumthreads#new',    via: 'get',  as: :new_cat_forumthread
  match '/:category_id/forumthreads',     to: 'forumthreads#create', via: 'post', as: :create_cat_forumthread

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'forumthreads#index'
end
