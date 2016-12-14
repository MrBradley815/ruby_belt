class UsersController < ApplicationController
    before_action :require_login
    before_action :require_correct_user, only: [:edit, :update]
    def index
        @users = User.all
    end
    def new

    end
    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            redirect_to "/events"
        else
            flash[:errors] = user.errors.full_messages
            redirect_to root_path
        end
    end
    def show
        @user = User.find(params[:id])
    end
    def edit
        @user = User.find(params[:id])
    end
    def update
        User.find(current_user.id).update(update_params)
        redirect_to "/users"
    end
    def destroy
        User.find(params[:id]).destroy
        redirect_to "/users"
    end

    private
        def user_params
            params.require(:user).permit(:first, :last, :email, :password, :password_confirmation)
        end
        def update_params
            params.require(:user).permit(:first, :last, :email)
        end
end
