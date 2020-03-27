require 'rest-client'
user = User.create(username:"Admin", password:'Admin') 
## there are missing letters because the DB does not have recipes for all letters in the alphabet 
letters = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','r','s','t','v','w','y']
letters.each do |l|
  recipes_str = RestClient.get 'https://www.themealdb.com/api/json/v1/1/search.php?f=' + l
  recipes = JSON.parse(recipes_str)
  recipes["meals"].each do |r| 
    new_r = Recipe.create(
      title: r["strMeal"], 
      category: r["strCategory"], 
      area: r["strArea"], 
      directions: r["strInstructions"],
      img: r["strMealThumb"]
    )
    r["strIngredient1"]
    i = 1
    while i < 20 do 
      if r["strIngredient" + i.to_s] != nil && r["strIngredient" + i.to_s] != ''
      ing = Ingredient.find_or_create_by(ing_name: r["strIngredient" + i.to_s])
        if r['strMeasure' + i.to_s] != nil && r['strMeasure' + i.to_s] != ''
        RecipeIngredient.create(ingredient_id: ing.id, recipe_id: new_r.id, amount: r['strMeasure' + i.to_s])
        else 
          RecipeIngredient.create(ingredient_id: ing.id, recipe_id: new_r.id)
        end 
      end 
      i += 1
    end 
    UserRecipe.create(user_id: user.id, recipe_id: new_r.id)
  end 
end 