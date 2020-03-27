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
        ingredients = params[:recipe][:ingredients] 
        response = recipe.create_recipe(user, ingredients)
        render json: response
      else 
        render json: {error: 'Something went wrong'}
      end 
    end

    def update 
      recipe = Recipe.find(params[:id]) 
      recipe.update(recipe_params)
      if recipe.save 
        ingredients = params[:ingredients]
        response = recipe.update_recipe(ingredients)
        render json: response  
      else 
        render json: {error: 'Something went wrong'}
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
      params.require(:recipe).permit(
        :title, 
        :img, 
        :directions, 
        :area, 
        :category, 
        :rating, 
        :id, 
        ingredients: []
      )
    end

end
    