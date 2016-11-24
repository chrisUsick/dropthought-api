require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  setup do
    @user = User.create({
      uid: '1234', provider: 'google_auth2', password: 'passw000rd'
    })
    @auth_headers = @user.create_new_auth_token
  end
  test 'creates an order' do
    product = Product.first
    product.wishers << @user
    assert_equal 1, product.wishers.size
    post url_for(controller: 'orders', action: 'create'),
      params: {
        product: {id: product.id, price: product.price},
        customizations: [{id: 1, price: 5.99, selected: true}]
      }, xhr: true, headers: @auth_headers
    assert_response :success
    order = User.first.orders.first
    assert_equal product.price, order.price.to_f
    assert_equal 1, order.customization_prices.size
    assert_equal 5.99, order.customization_prices.first.price
    assert_equal 0, product.reload.wishers.size
  end
end
