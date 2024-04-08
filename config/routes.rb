Rails.application.routes.draw do
  devise_for :users
  # Session routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy', as: :logout
  get 'logout', to: 'devise/sessions#destroy', as: :logout_get



  # Admin namespace
  namespace :admin do
    resources :users
    resources :tasks do
      member do
        patch :toggle_solved
        delete 'remove_assignee/:user_id', to: 'tasks#remove_assignee', as: 'remove_assignee_from_task'
      end
    end
  end

  # Assuming you have a TasksController for non-admin users
  resources :tasks, only: [] do
    member do
      patch :solve, to: 'tasks#solve' # This route is for non-admin users to mark tasks as solved
    end
  end

  # Health check URL
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root 'welcome#index'
end
