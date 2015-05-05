Rails.application.routes.draw do
  get 'api' => 'api#delegate'
  post 'api' => 'api#delegate'
  root "users#index"
  resources :users, except: :new
  get '/signup', to: 'users#new'

end
