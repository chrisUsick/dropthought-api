require 'test_helper'

class ProductControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'search' do
    get :search, params: {keywords: 'word 1'}, xhr: true
    assert_response :success
  end
end
