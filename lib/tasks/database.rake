require 'sequel'
require 'yaml'

namespace :db do
  Sequel.extension :migration

  ROOT_PATH = File.expand_path('../../../', __FILE__)
  MIGRATIONS_PATH = File.join(ROOT_PATH, 'db', 'migrations')
  DB_CONFIG = YAML.load_file(File.join(ROOT_PATH, 'config', 'database.yml'))
  RACK_ENV  = ENV.fetch('RACK_ENV', 'development')
  DB = Sequel.connect(DB_CONFIG[RACK_ENV], symbolize_keys: true)

  task :migrate do
    Sequel::Migrator.run(DB, MIGRATIONS_PATH)
  end

  task :reset do
    Sequel::Migrator.run(DB, MIGRATIONS_PATH, target: 0)
  end

  task :seed do
    DB.transaction do
      @user = User.create({
        first_name: 'John',
        last_name: 'Doe',
        email: 'john.doe@gmail.com',
        username: 'john.doe',
        password: 'john.doe'
      })

      @user.add_account(number: 1234, name: "John's personal accont.")
      @user.add_account(number: 1234, name: "John's secret accont.")
    end
  end
end