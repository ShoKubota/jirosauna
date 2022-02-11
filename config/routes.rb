Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'static_pages#top'
  get 'terms', to: 'static_pages#terms'
  get 'privacy_policy', to: 'static_pages#privacy_policy'
  resources :jiros, only: %i[index show]
  get 'maps', to: 'maps#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
