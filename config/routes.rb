Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  root 'visitor#index'
  resources :visitor, only: [:index, :show] do
    collection do
      get 'analyze_problem'  # GET for form
      post 'analyze_problem' # POST for AI analysis
    end
  end

  get 'algorithm_categories/:slug', to: 'algorithm_categories#show', as: 'algorithm_category'
  get 'algorithms/:slug', to: 'algorithms#show', as: 'algorithm'

  namespace :api do
    resources :algorithm_categories, only: [:index]
    resources :algorithms, only: [:index, :show]
  end
end
