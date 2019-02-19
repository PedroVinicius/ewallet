require 'sequel'
require 'yaml'
require 'bcrypt'

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
      @user = DB[:users].insert({
        first_name: 'John',
        last_name: 'Doe',
        username: 'john.doe',
        email: 'john.doe@gmail.com',
        encrypted_password: BCrypt::Password.create('john.doe')
      })

      DB[:accounts].insert({ user_id: @user, number: 1222, name: "John's personal account." })
      DB[:accounts].insert({ user_id: @user, number: 1333, name: "John's secret account." })
    end
  end
end