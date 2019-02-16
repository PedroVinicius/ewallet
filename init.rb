require 'bundler'
require 'dotenv'
require 'yaml'
require 'openssl'

Bundler.require(:default)
Dotenv.load

APPLICATION_ROOT = File.expand_path('..', __FILE__)
RACK_ENV = ENV.fetch('RACK_ENV', 'development')

db_config = File.read(File.join(APPLICATION_ROOT, 'config', 'database.yml'))
DB = Sequel.connect(YAML.load(db_config)[RACK_ENV])

Dir.glob(File.join(APPLICATION_ROOT, '{lib,models}', '**', '*.rb'), &method(:require))