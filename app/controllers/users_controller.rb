class UsersController < ApplicationController

    def index
        @users = User.all
        render :json => @users
       
    end

    def show
        # @user = User.find(params[:id])

        # owned_user_recipes = @user.user_recipes.where(favorite: false)
        # owned_recipe_ids = owned_user_recipes.map{|r| r.recipe.id}
        # @my_recipes = owned_recipe_ids.map {|r_id| {recipe: Recipe.find(r_id), ingredients: Recipe.find(r_id).ingredients}  }

        # favorite_user_recipes = @user.user_recipes.where(favorite: true)
        # favorite_recipe_ids = favorite_user_recipes.map{|r| r.recipe.id}
        # @favorite_recipes = favorite_recipe_ids.map {|r_id| {recipe: Recipe.find(r_id), ingredients: Recipe.find(r_id).ingredients } }
        user = User.find(params[:id])
        render :json => user

        # @userRecipes = {
        #     owned_recipes: @my_recipes,
        #     favorite_recipes: @favorite_recipes
        # }

        # render :json => @userRecipes
    end

    def create
        user = User.new(username: params[:username], password: params[:password])
        if user.save
            render json: {success: 'User was successfully created'}
        else
            ### error handle 
        end 
    end

    private 

    def user_params
        params.require(:user).permit(:username, :password)
    end 


end
