RACK_ENV = ENV['RACK_ENV'] = 'test'
APP_ROOT = File.expand_path('../../', __FILE__)

require 'sinatra'
require 'sequel'
require 'minitest/autorun'
require 'rack/test'
require 'yaml'

include Rack::Test::Methods

require File.join(APP_ROOT, 'app')

DB_CONFIG = YAML.load_file(File.join(APP_ROOT, 'config', 'database.yml'))
DB = Sequel.connect(DB_CONFIG[RACK_ENV])

def app
  Ewallet::App
end