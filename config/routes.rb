# frozen_string_literal: true

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  root 'users#index'

  # Defines the root path route ("/")
  # root "articles#index"
  resources :users, only: [:index, :show] do
    resources :posts, controller: 'users/posts' do
      resources :comments, only: [:new, :create], controller: 'users/posts/comments'
      resources :likes, only: [:create], controller: 'users/posts/likes'
    end
  end

end
