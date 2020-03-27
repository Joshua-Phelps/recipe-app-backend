class UsersController < ApplicationController

    def index
        users = User.all
        render :json => users   
    end

    def show
        user = User.find(params[:id])
        render :json => user
    end

    def create
        user = User.new(username: params[:username], password: params[:password])
        if user.save
            render json: {success: 'User was successfully created'}
        else
            render json: {error: 'Something went wrong'}
        end 
    end

    private 

    def user_params
        params.require(:user).permit(:username, :password)
    end 

end
