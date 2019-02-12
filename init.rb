require 'bundler'
require 'dotenv'

Bundler.require(:default)
Dotenv.load

APPLICATION_ROOT = File.expand_path('..', __FILE__)

Dir.glob(File.join(APPLICATION_ROOT, '{lib,models}', '**', '*.rb'), &method(:require))