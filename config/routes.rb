require 'api_constraints'

Rails.application.routes.draw do

  namespace :api, defaults: { format: :json }, path: '/api/v1' do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do

      #users
      resources :users, :only => [:show, :create, :update, :destroy,:index]

      #sessions
      delete '/sessions/logout', to: 'sessions#destroy'
      post '/sessions/login', to: 'sessions#create'


      devise_for :users
    end
  end

  root 'static_pages#home'

  post   'login'   => 'sessions#create'
  delete 'logout'  => 'sessions#destroy'
  get 'dashboard' => 'dashboard#index'

  resources :users

end