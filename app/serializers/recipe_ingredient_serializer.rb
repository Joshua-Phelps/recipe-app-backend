class RecipeIngredientSerializer < ActiveModel::Serializer
  attributes :id, :amount
  has_one :recipe
  has_one :ingredient
end
