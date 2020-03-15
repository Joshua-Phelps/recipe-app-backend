class RecipesController < ApplicationController

    def index
        # recipes = Recipe.all 
        recipes = Recipe.all[0...9]
        render json: recipes 
    end

    def show 
        recipe = Recipe.find(params[:id])
        render json: recipe
    end 

    def create
        @user = User.find(params[:userId])
        @recipe = Recipe.new(
            titel: params[:title], 
            img: params[:image], 
            directions: params[:directions], 
            area: params[:area], 
            category: params[:category], 
            rating: params[:rating]
        )
        ing_array = [] 
        if @recipe.save
            @user_recipe = UserRecipe.new(recipe_id: @recipe, user_id: @user)
            @user_recipe.save
            params[:ingredients].each do |ing|
                @ingredient = Ingredient.find_or_create_by(ing_name: ing[:ingName])
                if @ingredient.save 
                    ing_array.push(@ingredient)
                @recipe_ingredient = RecipeIngredient.new(recipe_id: @recipe, ingredient_id: @ingredient, amount: ing[:amount] )
                @recipe_ingredient.save 
                end 
            end
            render json: {recipe: @recipe, ingredients: ing_array}
        end 
    end

    def update
        @recipe = Recipe.find(params[:id])
        if params[:title] 
            @recipe.title = params[:title]
            @recipe.img = params[:image]
            @recipe.directions = params[:directions]
            @recipe.area = params[:area]
            @recipe.category = params[:category]
            @recipe.rating = params[:rating]
            @recipe_ings = RecipeIngredient.where(recipe_id: @recipe) 
            @recipe_ings.destroy_all
            params[:ingredients].each do |ing|
                if ing[:ingName] != ''
                    @ingredient = Ingredient.find_or_create_by(ing_name: ing[:ingName])
                        if @ingredient.save 
                        @recipe_ingredient = RecipeIngredient.new
                        @recipe_ingredient.recipe = @recipe
                        @recipe_ingredient.ingredient = @ingredient
                        @recipe_ingredient.amount = ing[:amount]
                        @recipe_ingredient.save
                    end 
                end 
            end
            @recipe.save 
            render json: {recipe: @recipe, ingredients: @recipe.ingredients}
        else 
            @recipe.rating = params[:rating]
            @recipe.save 
            render json: {recipe: @recipe, ingredients: @recipe.ingredients}
        end 
    end

    def destroy
        @recipe = Recipe.find(params[:id])
        @recipe_ingredients = RecipeIngredient.where(recipe_id: @recipe)
        @user_recipes = UserRecipe.where(recipe_id: @recipe)
        @recipe_ingredients.destroy_all
        @user_recipes.destroy_all
        @recipe.destroy
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
    
    #     @user_recipe = UserRecipe.create(recipe_id: @recipe.id, user_id: 22)
        
    # end
