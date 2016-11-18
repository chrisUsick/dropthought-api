class ProductController < ApplicationController
  # before_action :set_user_by_token
  def index
    # access_token = request.headers['access-token']
    # client = request.headers['client']
    #
    # if User.validate(access_token, client)
    #   p 'Authed'
    #   p current_user
    # end
    # p
    render json: Product.all
  end

  def search
    keywords = params['keywords']
    products = Product.left_outer_joins(:tags).where %{
      lower(products.name) LIKE :keywords OR
      lower(products.description) LIKE :keywords OR
      lower(tags.name) LIKE :keywords
    },
                                                     keywords: "%#{keywords.downcase}%"
    tags = products.map(&:tags).flatten.uniq(&:id)
    render json: {
      products: products.as_json(include: :tags),
      tags: tags
    }
  end
end
