Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  namespace :admin do
    resources :users
    resources :tasks do
      member do
        patch :toggle_solved
        delete 'remove_assignee/:user_id', to: 'tasks#remove_assignee', as: 'remove_assignee_from_task'
      end
    end
  end


  # Health check URL
  get "up" => "rails/health#show", as: :rails_health_check

  # Root path
  root 'welcome#index'
end
