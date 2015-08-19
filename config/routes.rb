require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  root to: 'pictures#index'

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      devise_scope :user do
        match '/sessions' => 'sessions#create', :via => :post
        match '/sessions' => 'sessions#destroy', :via => :delete
      end

      resources :users, only: [:create]
      match '/users' => 'users#show', :via => :get
      match '/users' => 'users#update', :via => :put
      match '/users' => 'users#destroy', :via => :delete

      get 'categories/categories_with_pics' => 'categories#categories_with_pics', as: 'category_with_pics'
      resources :categories

      resources :pictures do
        member { post :like}
        member { post :dislike }
      end
      
      resources :comments, only: [:create, :destroy, :update]
    end
  end
end
