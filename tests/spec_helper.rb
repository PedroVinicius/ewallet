RACK_ENV = ENV['RACK_ENV'] = 'test'

require File.expand_path('../../init', __FILE__)
require File.join(APPLICATION_ROOT, 'app')

module RSpecMixin
  include Rack::Test::Methods
  
  def app
    Ewallet::App
  end
end

RSpec.configure { |c| c.include RSpecMixin }