class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password
  # has_many :user_recipes
  has_many :recipes, through: :user_recipes 


  # def created_recipes
  #   # byebug
  #   object.user_recipes.where(favorite: false).map do |created_recipe|
  #     UserRecipeSerializer.new(created_recipe, scope: scope, root: false)
  #   end
  # end

end
