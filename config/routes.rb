# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :ideas, :users
      post 'authorize' => "users#authorize"
    end
  end
end
