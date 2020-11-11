class UsersController < ApplicationController
    def index
        @users = User.all
        @user = User.new
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        respond_to do |format|
            if @user.save
              format.html { redirect_to users_path, notice: 'User was successfully created.' }
            else
              format.html { redirect_to users_path, notice: 'User was successfully created.' }
            end
        end
    end

    def find_valid_email
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :url)
    end
end
