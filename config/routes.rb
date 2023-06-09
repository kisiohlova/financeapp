Rails.application.routes.draw do
  get 'main/index'
  get 'reports/index'
  get 'reports/report_by_category'
  get 'reports/report_by_dates'
  resources :operations
  resources :categories

  root 'main#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
