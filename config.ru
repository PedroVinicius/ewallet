require File.expand_path('../init', __FILE__)
require File.expand_path('../app', __FILE__)

PUBLIC_KEY = File.read(ENV.fetch('PUBLIC_KEY_PATH', ''))

use Ewallet::AuthenticationMiddleware, PUBLIC_KEY, except_for: ['/users/sign_in']

run Rack::URLMap.new({
  '/api/v1' => Ewallet::App
})