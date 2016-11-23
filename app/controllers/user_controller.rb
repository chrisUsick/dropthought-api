class UserController < ApplicationController
  before_action :authenticate_user!
  wrap_parameters format: [:json]
  def all
    current_user.products.all
    render json: {
      user: current_user,
      products: current_user.products,
    }
  end

  def add_to_wishlist
    # p params[:user]
    product = Product.find(params[:product_id])
    current_user.wishlist_products << product
    current_user.save
  end

  def show_wishlist
    render json: current_user.wishlist_products.includes(:customizations).as_json(include: :customizations)
  end
  private
  def wishlist_params
    params.require(:product).permit(:id)
  end
end
