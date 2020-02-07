class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :img, :directions, :area, :category, :rating 
  has_many :user_recipes
  has_many :users, through: :user_recipes
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
end
