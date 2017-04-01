# frozen_string_literal: true
require_relative '../lib/crab_core'

namespace :db do
  desc "Create database"
  task :create do
    db = CrabCore::Repository.connection_without_database
    config = CrabCore::Repository.config
    db.run("CREATE DATABASE #{config['database']};")
    db.disconnect
    puts "Database created"
  end

  desc "Migrate database version"
  task :migrate do
    db = CrabCore::Repository.connection
    db.create_table :dictionary do
      primary_key :id
      String :word
    end
    db.run("CREATE UNIQUE INDEX index_dictionary_on_word ON dictionary (word);")
    puts "Dictionary table created"
  end

  desc "Setup database (create, migrate)"
  task :setup do
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
  end
end
