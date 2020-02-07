Rails.application.routes.draw do
  resources :recipe_ingredients
  resources :ingredients
  resources :user_recipes
  resources :recipes
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
