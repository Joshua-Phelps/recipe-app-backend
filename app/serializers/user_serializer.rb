class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :favorite_recipes, :recipes
  has_many :recipes, through: :user_recipes 
  has_many :favorite_recipes, through: :user_recipes

  def favorite_recipes
    favorite_recipes = object.user_recipes.where(favorite: true)
    favorite_recipe_ids = favorite_recipes.map{|r| r.recipe_id}
  end 

  def recipes
    recipes = object.user_recipes.where(favorite: false)
    recipe_ids = recipes.map{|r| r.recipe_id}
  end


end
