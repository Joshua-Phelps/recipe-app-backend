require 'rest-client'
recipes_str = RestClient.get 'https://www.themealdb.com/api/json/v1/1/search.php?f=c'
recipes = JSON.parse(recipes_str)
# byebug
user = User.find(29)
# user = User.create(username:"Admin", password:'Admin') 
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
    RecipeIngredient.create(ingredient_id: ing.id, recipe_id: new_r.id)
    end 
    i += 1
  end 
  UserRecipe.create(user_id: user.id, recipe_id: new_r.id)
end 

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Recipe.create(title:"test Title", img: "fake img", directions:'mix them', area:'here', category:'food', rating:'5' )
# UserRecipe.create(user_id: 1, recipe_id: 1)
# Ingredient.create(ing_name: 'potato' )
# RecipeIngredient.create(recipe_id: 1, ingredient_id: 1, amount: '7')


# User.create(username:"Josh", password:'test')
# User.create(username:"Bahay", password:'test')
# User.create(username:"Natali", password:'test')
# User.create(username:"Alice", password:'test')
# User.create(username:"Mia", password:'test')
# User.create(username:"Drew", password:'test')
# User.create(username:"Tanner", password:'test')
# User.create(username:"Sean", password:'test')
# User.create(username:"Mengs", password:'test')
# User.create(username:"Amy", password:'test')
# User.create(username:"Nicole", password:'test')
# User.create(username:"Jacob", password:'test')
# User.create(username:"Matt", password:'test')
# User.create(username:"John", password:'test')
# User.create(username:"Ix", password:'test')
# User.create(username:"Soundarya", password:'test')