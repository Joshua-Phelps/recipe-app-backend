class Recipe < ApplicationRecord
  has_many :user_recipes 
  has_many :users, through: :user_recipes
  has_many :recipe_ingredients
  has_many :ingredients, through: :recipe_ingredients
  accepts_nested_attributes_for :ingredients
    
  def create_recipe(user, ingredients)
    user_recipe = UserRecipe.new(recipe_id: self.id, user_id: user.id)
    user_recipe.save
    ingredients.each do |ing|            
      if ing[:ing_name] != '' && ing[:ing_name] != nil 
        ingredient = Ingredient.find_or_create_by(ing_name: ing[:ing_name])
          recipe_ingredient = RecipeIngredient.create(
            recipe_id: self.id, 
            ingredient_id: ingredient.id, 
            amount: ing[:amount] 
          )
      end 
    end 
    self
  end

  def update_recipe(ingredients)  
    recipe_ingredients = RecipeIngredient.where(recipe_id: self.id) 
    recipe_ingredients.destroy_all
    ingredients.each do |ing| 
      if ing[:ing_name] != '' && ing[:ing_name] != nil 
        ingredient = Ingredient.find_or_create_by(ing_name: ing[:ing_name])
          if ingredient.save 
          recipe_ingredient = RecipeIngredient.new(
            recipe_id: self.id, 
            ingredient_id: ingredient.id, 
            amount: ing[:amount]
          )
          recipe_ingredient.save
        end 
      end 
    end
    self
  end 
end
