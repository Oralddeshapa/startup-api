# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :api do
    namespace :v1 do
      resources :ideas, :users, :comments
      post 'authorize' => "users#authorize"
      get 'get_fields' => "ideas#get_fields"
    end
  end
end
