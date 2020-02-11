class RecipesController < ApplicationController

    def index
        @recipes = Recipe.all 
        render json: @recipes 
    end

    def show 
        @recipe = Recipe.find(params[:id])
        render json: @recipe
    end 

    def create
        # byebug 
        ### need to add logic to add user to recipe 
        # @user = User.find(params[:user])
        @user = User.find(1)
        @recipe = Recipe.new 
        @recipe.title = params[:title]
        @recipe.img = params[:image]
        @recipe.directions = params[:directions]
        @recipe.area = params[:area]
        @recipe.category = params[:category]
        @user_recipe = UserRecipe.new 
        ing_array = [] 
        if @recipe.save
            @user_recipe.recipe = @recipe 
            @user_recipe.user = @user
            params[:ingredients].each do |ing|
                @ingredient = Ingredient.find_or_create_by(ing_name: ing[:ingName])
                if @ingredient.save 
                    ing_array.push(@ingredient)
                @recipe_ingredient = RecipeIngredient.new
                @recipe_ingredient.recipe = @recipe
                @recipe_ingredient.ingredient = @ingredient
                @recipe_ingredient.amount = ing[:amount]
                @recipe_ingredient.save 
                end 
            end
            render json: {recipe: @recipe, ingredients: ing_array}
        end 


    end
    
    # private 
    # def recipe_params
    #     params.require(:recipe).permit(:title, :img, :directions, :area, :category, :rating)
    # end
    
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

#     @user_recipe = UserRecipe.create(recipe_id: @recipe.id, user_id: 7)
    
# end