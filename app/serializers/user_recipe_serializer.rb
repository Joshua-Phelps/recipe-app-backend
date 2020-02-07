class UserRecipeSerializer < ActiveModel::Serializer
  attributes :id, :favorite, :recipe_id, :user_id
  has_one :user
  has_one :recipe
end
