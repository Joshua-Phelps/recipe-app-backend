class UserRecipesController < ApplicationController

    def create
        user_favorite_recipe = UserRecipe.new(user_recipe_params) 
        if user_favorite_recipe.save
            render json: user_favorite_recipe
        else 
            render json: {error: 'Something went wrong'}
        end
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

