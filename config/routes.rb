Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "articles#index"
  get 'about', to: "pages#about"
  resources :articles
  get '/auths/login', to: 'auths#login', :as => :auth_login
  post '/auths/authenticate', to: 'auths#authenticate', :as => :auth_authenticate
  delete '/auths/destroy', to: 'auths#destroy', :as => :auth_destroy
  resources :auths
  resources :users
end
