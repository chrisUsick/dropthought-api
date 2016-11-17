Rails.application.routes.draw do

  mount_devise_token_auth_for 'User', at: 'auth'
  scope '/api' do
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
    # options '/auth/google' => 'google_token_auth#auth'
    post '/auth/google' => 'google_token_auth#auth'
    get '/products' => 'product#index'
  end

  get '/test' => 'google_token_auth#test'
  # root to: 'static#index'
  # get '/admin' => 'static#index'
end
