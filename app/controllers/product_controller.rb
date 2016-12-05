class ProductController < ApplicationController
  before_action :authenticate_user!, only: [:create]
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

  def show
    id = params[:id]
    render json: Product
      .includes(:customizations, :tags)
      .find(id).as_json(include: [:customizations, :tags])
  end

  def create
    render json: current_user.products.create(product_params)
  end

  def update
    attributes = product_params
    p attributes
    attributes[:tags_attributes] = attributes.delete :tags
    id = params[:id]
    product = Product.find id
    # attributes[:tags].each do |t|
    #   unless t['created_at']
    #     product.tags.build(t)
    #   end
    # end
    if product.update attributes
      render status: 200
    else
      render status: 400
    end
  end

  def delete
    id = params[:id]
    Product.find(id).delete
  end

  def popular
    render json: Product.limit(3)
  end

  private

  def product_params
    params.permit(:description, :name, :price, customizations: [], tags: [:id, :name, :slug, :_destroy])
  end


end
