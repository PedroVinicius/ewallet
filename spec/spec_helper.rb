require File.expand_path('../../init', __FILE__)
require File.join(APPLICATION_ROOT, 'app')

module RSpecMixin
  include Rack::Test::Methods
  
  def app
    Ewallet::App
  end
end

DatabaseCleaner.strategy = :truncation

RSpec.configure do |c|
  c.include RSpecMixin

  c.before(:all) do
    DatabaseCleaner.clean
  end

  c.after(:each) do
    DatabaseCleaner.clean
  end
end