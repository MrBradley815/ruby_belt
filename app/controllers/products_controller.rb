class ProductsController < ApplicationController
    def index
        @products = Product.where("user_id != ? AND buyer_id IS NULL",current_user)
    end
    def create
        product = Product.new(name:product_params[:name],price:product_params[:price],user:current_user)
        if product.save
            redirect_to "/users/#{current_user.id}"
        else
            flash[:errors] = product.errors.full_messages
            redirect_to :back
        end
    end
    def update
        Product.find(params[:id]).update(buyer:current_user)
        redirect_to "/users/#{current_user.id}"
    end
    def destroy
        Product.find(params[:id]).destroy
        redirect_to :back
    end

    private
        def product_params
            params.require(:product).permit(:name, :price)
        end
end
