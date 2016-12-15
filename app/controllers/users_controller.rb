class UsersController < ApplicationController
    def create
        user = User.new(user_params)
        if user.save
            session[:user_id] = user.id
            redirect_to "/products"
        else
            flash[:errors] = user.errors.full_messages
            redirect_to root_path
        end
    end
    def show
        @selling = Product.where(user:current_user,buyer:nil)
        @sold = Product.where("user_id = ? AND buyer_id IS NOT NULL",current_user)
        @bought = Product.where(buyer:current_user)
        @sales = Product.where("user_id = ? AND buyer_id IS NOT NULL",current_user).sum(:price)
        @purchases = User.find(current_user.id).bought_products.sum(:price)
    end

    private
        def user_params
            params.require(:user).permit(:first, :last, :email, :password, :password_confirmation)
        end
end
