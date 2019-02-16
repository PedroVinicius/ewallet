module Ewallet
  class App < Sinatra::Base
    PUBLIC_KEY_PATH  = File.read(ENV.fetch('PUBLIC_KEY_PATH'))
    PRIVATE_KEY_PATH = File.read(ENV.fetch('PRIVATE_KEY_PATH'))

    set :public_key, OpenSSL::PKey.read(PUBLIC_KEY_PATH)
    set :private_key, OpenSSL::PKey.read(PRIVATE_KEY_PATH)

    before do
      content_type 'application/json'
      request.body.rewind

      @body = JSON.parse(request.body.read)
    end

    get '/accounts' do
      
    end
  
    post '/accounts' do
  
    end
  
    get '/accounts/:id' do

    end

    put '/accounts/:id' do

    end
  
    post '/accounts/:id/transfer/:destination_id' do

    end
  
    post '/users' do

    end
  
    post '/users/sign_in' do

    end
  end
end