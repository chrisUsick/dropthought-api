class OrdersController < ApplicationController
  before_action :authenticate_user!
  def create
    product_attr = product_params
    product = Product.find(product_attr[:id])
    if current_user.wishlist_products.exists?(product.id)
      current_user.wishlist_products.delete(product)
    end
    order = current_user.orders.create(product_id: product.id,
                                       status: :new,
                                       fulfiller_id: product.user.id)
    customization_prices = []
    customization_prices_params[:customizations].each do |c|
      next unless c['selected']
      customization_prices << ({
        customization_id: c['id'],
        price: c['price']
      })
    end
    order.customization_prices.create(customization_prices)
    price = product.price
    price += customization_prices.inject(0) {|out, c| out += c[:price]; out}
    order.price = price
    order.save
    create_charge order, params[:token]
    render status: 200
  rescue Stripe::CardError => e
    render status: 400, json: {
      error: {
        message: e.message
      }
    }
  end

  def update
    order = Order.find(update_params[:id])
    order.status = update_params[:status]
    if order.save
      render json: order
        .as_json(include: [{customization_prices: {include: :customization}}, :product])
    end
  end

  private

  def update_params
    params.permit(:id, :status)
  end

  def product_params
    params.require(:product).permit(:id, :price)
  end

  def customization_prices_params
    params.permit(customizations: [:selected, :id, :price])
  end

  def create_charge(order, token)
    customer = Stripe::Customer.create(
      email: current_user.email,
      source: token,
      description: "customer for #{current_user.email}; uid: #{current_user.uid}"
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: order.price,
      description: "purchase of #{order.product.name}; by #{customer.email}",
      currency: 'cad'
    )
  end
end
