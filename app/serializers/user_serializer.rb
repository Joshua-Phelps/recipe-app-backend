class UserSerializer < ActiveModel::Serializer
  attributes :id, :username
  has_many :recipes, through: :user_recipes 
  has_many :favorite_recipes, through: :user_recipes

  def favorite_recipes
    favorite_recipes = object.user_recipes.where(favorite: true)
    favorite_recipe_ids = favorite_recipes.map{|r| r.recipe_id}
    # favorite_recipes.map do |recipe|
    #   ActiveModelSerializers::SerializableResource.new(recipe)
    # end 
  end 

  def recipes
    recipes = object.user_recipes.where(favorite: false)
    recipe_ids = recipes.map{|r| r.recipe_id}
  end


end
