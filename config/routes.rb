Rails.application.routes.draw do
  get 'maps', to: 'maps#search'
  get 'maps/result', to: 'maps#result'
  root 'static_pages#top'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
