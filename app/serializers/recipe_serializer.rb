class RecipeSerializer < ActiveModel::Serializer
  attributes :id, :title, :img, :directions, :area, :category, :rating, :ingredients


  def ingredients
    ingredients = object.ingredients.map do |ing| 
      amount = ing.recipe_ingredients.find_by(recipe_id: object.id)[:amount]
      new_ing = {id: ing.id, ing_name: ing.ing_name, amount: amount}
    end
  end 

end
