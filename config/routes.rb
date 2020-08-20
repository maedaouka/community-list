Rails.application.routes.draw do
  get    '/login',    to: 'firebase#new'
  post   '/login',    to: 'sessions#create'
  delete '/logout',   to: 'sessions#destroy'
  post   '/accounts', to: 'accounts#create'

  get "login" => "sessions#new"
  resources :team_users
  resources :teams, param: :uid
  resources :users

  root 'users#mypage'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
