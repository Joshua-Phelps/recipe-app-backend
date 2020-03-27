Rails.application.routes.draw do
  resources :user_recipes, only: [:create, :destroy]
  resources :recipes, only: [:index, :create, :show, :update, :destroy]
  resources :users, only: [:index, :show, :create]
  post '/auth', to: 'auth#create'
  get '/current_user', to: 'auth#show'
  # patch '/ratings/:id', to: 'user_recipes#update_rating'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
