class LoginController < ApplicationController
    def create
        user = User.find_by(username: params[:username])
        
        if user && user.password === params[:password]
             
            render :json => user 
        else 
            render :json => {error: "User not found or password is incorrect"}
        end 
    end

    def destroy 
        
    end
end
