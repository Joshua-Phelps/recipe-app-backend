class UserRecipeSerializer < ActiveModel::Serializer
  attributes :id, :favorite
  has_one :user
  has_one :recipe
end
