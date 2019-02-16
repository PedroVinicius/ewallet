require 'dotenv/tasks'
require 'rake/testtask'

Dir.glob('./lib/tasks/*.rake', &method(:load))

Rake::TestTask.new do |t|
  t.pattern = 'tests/*_spec.rb'
  t.ruby_opts = ['-r', 'dotenv/load']
end