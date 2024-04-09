Rails.application.routes.draw do
  # Devise routes for users
  devise_for :users

  # Admin namespace for resources
  namespace :admin do
    resources :users
    resources :tasks do
      member do
        patch :toggle_solved
        delete 'remove_assignee/:user_id', to: 'tasks#remove_assignee', as: 'remove_assignee_from_task'
      end
    end
  end

  # Tasks routes for non-admin users (assuming they exist)
  resources :tasks, only: [] do
    member do
      patch :solve, to: 'tasks#solve' # For non-admin users to mark tasks as solved
    end
  end

  # Health check URL
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path of the application
  root 'welcome#index'
end
