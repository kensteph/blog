# frozen_string_literal: true

Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'users#index'

  # Defines the root path route ("/")
  # root "articles#index"
  resources :posts, only: [:new, :create]
  resources :users, only: [:index, :show] do
    resources :posts, controller: 'users/posts' do
      resources :comments, only: [:new, :create, :destroy], controller: 'users/posts/comments'
      resources :likes, only: [:create], controller: 'users/posts/likes'
    end
  end

  #API
  namespace :api, defaults: {format: 'json'} do
    namespace :v0 do
      resources :users, only: :show do
        resources :posts, only: [:index, :show], shallow: true do
          resources :comments, only: [:index, :create]
        end
      end
    end
  end

end
