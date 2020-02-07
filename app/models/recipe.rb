class Recipe < ApplicationRecord
  has_many :user_recipes 
  has_many :users, through: :user_recipes
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  
  

  # def makeIngredients(ingredients)
  #   params["ingredients"].each do |ing|
  #     if ing[0].is_a? String || ing[1].is_a? String || ing[0] != ''  || ing[1] != '' || ing != []
  #         @ingredient = Ingredient.find_or_create_by(ing_name: ing[0])
  #         @recipe_ingredient = RecipeIngredient.create(recipe_id: @recipe, ingredient_id: @ingredient, amount: ing[1])    
  #     end 
  #   end 
  # end

end
