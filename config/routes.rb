Rails.application.routes.draw do
  get 'sessions/new'
  resources :team_users
  resources :teams, param: :uid
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
