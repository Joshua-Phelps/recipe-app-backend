class UserRecipesController < ApplicationController

    def create
        user_favorite_recipe = UserRecipe.new(user_recipe_params) 
        if user_favorite_recipe.save
            render json: user_favorite_recipe
        else 
            ### error handle 
        end
    end

    def update_rating
        byebug 
        ### add rating column to user_recipes table 
    end 

    def destroy
        user_recipe = UserRecipe.find_by(user_recipe_params)
        id = user_recipe.recipe_id
        user_recipe.destroy
        render json: id 
    end

    private 

    def user_recipe_params
        params.require(:user_recipe).permit(:id, :user_id, :recipe_id, :favorite, :rating)
    end 


end   

