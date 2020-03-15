Rails.application.routes.draw do
  resources :recipe_ingredients
  resources :ingredients
  resources :user_recipes
  resources :recipes
  resources :users
  resources :login 
  post '/auth', to: 'auth#create'
  get '/current_user', to: 'auth#show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
