Rails.application.routes.draw do
  resources :team_users
  resources :teams
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
