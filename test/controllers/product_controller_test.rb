require 'test_helper'

class ProductControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'search title' do
    get url_for(controller: 'product', action: 'search'),
        params: { keywords: 'tiny house' }, xhr: true
    assert_response :success

    assert_equal 1, JSON.parse(@response.body)['products'].size
  end

  test 'search description' do
    get url_for(controller: 'product', action: 'search'),
        params: { keywords: 'container' }, xhr: true
    assert_response :success
    assert_equal 1, JSON.parse(@response.body)['products'].size
  end

  test 'search tags' do
    get url_for(controller: 'product', action: 'search'),
        params: { keywords: 'vehicles' }, xhr: true
    assert_response :success
    res = JSON.parse(@response.body)
    assert_equal 1, res['products'].size
    assert_equal 1, res['tags'].size
  end

  test 'returns all tags' do
    get url_for(controller: 'product', action: 'search'),
        params: { keywords: 'a' }, xhr: true
    assert_response :success
    res = JSON.parse(@response.body)
    assert_equal 2, res['tags'].size
    ['home-designs', 'vehicles'].each do |slug|
      res['tags'].map { |t| t['slug'] }.include? slug
    end
  end

  test 'returns each product once' do
    get url_for(controller: 'product', action: 'search'),
        params: { keywords: 'home' }, xhr: true
    assert_response :success
    res = JSON.parse(@response.body)

    assert_equal 2, res['products'].size
  end

  test 'products have tags included on them' do
    get url_for(controller: 'product', action: 'search'),
        params: { keywords: 'tiny house' }, xhr: true
    assert_response :success
    res = JSON.parse(@response.body)
    assert_equal res['products'][0]['tags'][0]['slug'], 'home-designs'
  end
end
