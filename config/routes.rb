require 'api_constraints'

Rails.application.routes.draw do
  devise_for :users

  root to: 'pictures#index'

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      devise_scope :user do
        post '/sessions' => 'sessions#create'
        delete '/sessions' => 'sessions#destroy'
      end

      resources :users, only: [:create]
      get '/users' => 'users#show'
      put 'users/:email' => 'users#make_admin'
      put '/users' => 'users#update'
      delete '/users' => 'users#destroy'

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
