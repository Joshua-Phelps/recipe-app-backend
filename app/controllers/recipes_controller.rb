class RecipesController < ApplicationController

    def index 
        recipes = Recipe.all
        # last = Recipe.all.length 
        # last_recipes = Recipe.all[(last-10)...last]
        render json: recipes 
        # render json: last_recipes
    end

    def show 
        recipe = Recipe.find(params[:id])
        render json: recipe
    end 

    def create 
        user = User.find(params[:user_id])
        recipe = Recipe.new(recipe_params)
        if recipe.save
            user_recipe = UserRecipe.new(recipe_id: recipe.id, user_id: user.id)
            user_recipe.save
            params[:recipe][:ingredients].each do |ing|
             
                if ing[:ing_name] != '' && ing[:ing_name] != nil 
                    ingredient = Ingredient.find_or_create_by(ing_name: ing[:ing_name])
                    if ingredient.save
                        recipe_ingredient = RecipeIngredient.new(
                            recipe_id: recipe.id, 
                            ingredient_id: ingredient.id, 
                            amount: ing[:amount] 
                        )
                        recipe_ingredient.save 
                    end 
                end 
            end 
            render json: recipe
        else 
            ### error handle 
        end 
    end

    def update 
        recipe = Recipe.find(params[:id]) 
        recipe.update(recipe_params)
        recipe_ingredients = RecipeIngredient.where(recipe_id: recipe) 
        recipe_ingredients.destroy_all
        params[:ingredients].each do |ing| 
            if ing[:ing_name] != '' && ing[:ing_name] != nil 
                ingredient = Ingredient.find_or_create_by(ing_name: ing[:ing_name])
                    if ingredient.save 
                    recipe_ingredient = RecipeIngredient.new(recipe_id: recipe.id, ingredient_id: ingredient.id, amount: ing[:amount])
                    recipe_ingredient.save
                end 
            end 
        end
        if recipe.save 
            render json: recipe
        else 
            ## error handle 
        end 
    end


    def destroy
        recipe = Recipe.find(params[:id])
        recipe.recipe_ingredients.destroy_all
        recipe.user_recipes.destroy_all
        recipe.recipe_ingredients.destroy_all
        recipe.destroy
        render json: {success: 'Recipe destroyed'}
    end
    
    private 
    def recipe_params
        params.require(:recipe).permit(:title, :img, :directions, :area, :category, :rating, :id, ingredients: [])
    end

end
    
    # def create
    #     @recipe = Recipe.new 
    #     @recipe.title = params["title"]
    #     @recipe.img = params["img"]
    #     @recipe.directions = params["directions"]
    #     @recipe.area = params["area"]
    #     @recipe.category = params["category"]
    #     @recipe.save
    
    #     params["ingredients"].each do |ing|
    #         if (ing[0].is_a? String) && (ing[1].is_a? String) && ing[0] != ""  && ing[1] != '' && ing != []
    #             @ingredient = Ingredient.find_or_create_by(ing_name: ing[0])
          
    #             @recipe_ingredient = RecipeIngredient.create(recipe_id: @recipe.id, ingredient_id: @ingredient.id, amount: ing[1])  
            
    #         end 
    #     end 
    
    #     @user_recipe = UserRecipe.create(recipe_id: @recipe.id, user_id: 22)
        
    # end
