require 'bundler'
require 'dotenv'
require 'yaml'
require 'openssl'

RACK_ENV = ENV.fetch('RACK_ENV', 'development')
APPLICATION_ROOT = File.expand_path('..', __FILE__)

Bundler.require(:default, RACK_ENV)
Dotenv.load

Sequel::Model.plugin :timestamps, update_on_create: true
Sequel::Model.plugin :json_serializer

db_config = File.read(File.join(APPLICATION_ROOT, 'config', 'database.yml'))
DB = Sequel.connect(YAML.load(db_config)[RACK_ENV])

Dir.glob(File.join(APPLICATION_ROOT, '{lib,models}', '**', '*.rb'), &method(:require))