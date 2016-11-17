class ProductController < ApplicationController
  # before_action :set_user_by_token
  def index
    access_token = request.headers['access-token']
    client = request.headers['client']

    if User.validate(access_token, client)
      p 'Authed'
      p current_user
    end
    p
    render json: Product.all
  end
end
