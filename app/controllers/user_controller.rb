class UserController < ApplicationController
  before_action :authenticate_user!
  def all
    current_user.products.all
    render json: {
      user: current_user,
      products: current_user.products,
    }
  end
end
