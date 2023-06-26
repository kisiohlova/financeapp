Rails.application.routes.draw do
  get 'finance_app', to: 'main#index'
  get 'report_by_category', to: 'reports#report_by_category'
  get 'report_by_dates', to: 'reports#report_by_dates'
  get 'report_generator', to: 'reports#index'
  get 'report_category_by_date', to: 'reports#report_category_by_date'
  resources :operations
  resources :categories

  root 'main#index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
