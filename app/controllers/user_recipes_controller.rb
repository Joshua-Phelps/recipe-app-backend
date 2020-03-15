class UserRecipesController < ApplicationController

    def create
        user_favorite_recipe = UserRecipe.new(user_recipe_params) 
        if user_favorite_recipe.save
            render json: user_favorite_recipe
        else 
            ### error handle 
        end
    end

    def destroy
        user_recipe = UserRecipe.find_by(user_recipe_params)
        user_recipe.destroy
        render json: { success: 'Recipe has been removed from your favorites' }
    end

    private 

    def user_recipe_params
            params.require(:user_recipe).permit(:id, :user_id, :recipe_id, :favorite)
    end 

    # params.require(:user_recipe).permit(:user_id, :recipe_id, :favorite).with_defaults(favorite: false))

end   

