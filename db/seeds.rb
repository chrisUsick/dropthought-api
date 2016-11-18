# rubocop:disable Style/IndentArray
products = Product.create([
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
