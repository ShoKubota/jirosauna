Rails.application.routes.draw do
  root 'static_pages#top'
  get 'maps', to: 'maps#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
