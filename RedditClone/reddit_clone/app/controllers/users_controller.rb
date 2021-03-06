class UsersController < ApplicationController

    before_action :ensure_logged_in!, only: [:show, :index]

    def new
        @user = User.new
        render :new
    end
    
    def index
        @users = User.all
        render :index
    end

    def create
        @user = User.create(user_params)
        if @user.save
            log_in!(@user)
            redirect_to users_url
        else
            flash[:errors] = @user.errors.full_messages
            render :new
        end
            
    end

    def show
        @user = User.find(params[:id])
        render :show
    end

    private

    def user_params
        params.require(:user).permit(:username, :password)
    end
    
end
