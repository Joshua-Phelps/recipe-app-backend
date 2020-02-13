class UserRecipesController < ApplicationController

    def create
        user_recipe = UserRecipe.find_by(user_id: params[:user_id], recipe_id: params[:recipe_id]) 
        if user_recipe && user_recipe.favorite 
            user_recipe.destroy
            render json: { error:"there was an error", destroyed: true, message: 'Already in your favorites' }
        if user_recipe && !user_recipe.favorite
            render json: { error:"there was an error", message: 'You can not add your own recipe to favorites' }, status: 401
        else 

            user_recipe = UserRecipe.new 
            user_recipe.user_id = params[:user_id]
            user_recipe.recipe_id = params[:recipe_id]
            user_recipe.favorite = true
            if user_recipe.save
                favorite_recipe = Recipe.find(params[:recipe_id])
            end
            render json: {recipe: favorite_recipe, ingredients: favorite_recipe.ingredients}
        end
    end

    # def destroy
    #     user_recipe = UserRecipe.find(params[:id])
    #     user_recipe.destroy
    #     render json: { message: 'Recipe has been removed from your favorites' }
    # end

    # params.require(:user_recipe).permit(:user_id, :recipe_id, :favorite).with_defaults(favorite: false))

end   

