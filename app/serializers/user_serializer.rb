class UserSerializer < ActiveModel::Serializer
  attributes :id, :username, :password
  has_many :user_recipes
  has_many :recipes, through: :user_recipes 
end
