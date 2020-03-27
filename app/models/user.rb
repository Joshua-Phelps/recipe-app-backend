class User < ApplicationRecord
    has_secure_password
    has_many :user_recipes 
    has_many :recipes, through: :user_recipes
    has_many :favorite_recipes, :through => :user_recipes
    validates :username, uniqueness: true 
end
