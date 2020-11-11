class UsersController < ApplicationController
    before_action :set_user, only: [:update, :destroy]

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
              format.html { redirect_to users_path }
            else
              format.html { redirect_to users_path }
            end
        end
    end


    def destroy
        @user.destroy
        respond_to do |format|
            format.html { redirect_to users_path }
        end
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def user_params
        params.require(:user).permit(:first_name, :last_name, :url)
    end
end
