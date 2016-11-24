Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'
  scope '/api' do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # options '/auth/google' => 'google_token_auth#auth'
    post '/auth/google' => 'google_token_auth#auth'
    get '/products' => 'product#index'
    get '/products/search' => 'product#search'
    get '/products/:id' => 'product#show'
    post '/products/:id' => 'product#update'
    delete '/products/:id' => 'product#delete'
    post '/products' => 'product#create'
    get '/users/current/all' => 'user#all'
    post '/users/current/wishlist' => 'user#add_to_wishlist'
    get '/users/current/wishlist' => 'user#show_wishlist'
    get '/users/current/orders' => 'user#show_orders'

    post '/orders' => 'orders#create'
  end

  get '/test' => 'google_token_auth#test'
  # root to: 'static#index'
  # get '/admin' => 'static#index'
end
