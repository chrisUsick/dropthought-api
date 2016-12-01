# rubocop:disable Style/IndentArray
user = User.create(provider: 'google_oauth2',
                   uid: '114200677379683396895',
                   password: 'passw000rd')

products = user.products.create([
    {
      name: 'Tiny Home on Wheels',
      description: "A house mounted on a 15' trailer.",
      price: 99.98,
      image: 'https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=350&h=150'
    }, {
      name: 'Shipping container home',
      description: 'A house made from shipping containers',
      price: 74.99,
      image: 'https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=350&h=150'
    }, {
      name: 'Offroad gokart',
      description: 'a simple gokart design with a wide wheel-base and 15" clearance',
      price: 99.98,
      image: 'https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=300&h=150'
    }, {
      name: 'Gokart from lawnmower moter',
      description: 'A gokart made with a lawnmower moter',
      price: 99.98,
      image: 'https://placeholdit.imgix.net/~text?txtsize=33&txt=350%C3%97150&w=300&h=150'
    }
])
house_tag = products[0].tags.create(name: 'House', slug: 'house')
house_tag.products << products[1]

gokart_tag = products[2].tags.create(name: 'Vehicles', slug: 'vehicles')
gokart_tag.products << products[3]

products[0].customizations.create(
  name: 'Skylight', description: 'Add a skylight over the bed.', price: 25.00
)

products[0].wishers << user
products[0].save

user.orders.create([
  {
    product_id: products[2].id,
    status: :new,
    price: 99.98,
    fulfiller_id: user.id
  }
])

order = user.orders.create(product_id: products[0].id,
                           status: :complete,
                           price: 80.99,
                           fulfiller_id: user.id)

user.orders.create({
  product_id: products[1].id,
  status: :verified,
  price: 151.23,
  fulfiller_id: user.id
  })

order.customization_prices.create(customization_id: products[0].customizations.first.id,
                                  price: 22.10)
