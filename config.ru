require File.expand_path('../init', __FILE__)
require File.expand_path('../app', __FILE__)

run Rack::URLMap.new({
  '/api/v1' => Ewallet::App
})