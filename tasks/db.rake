# frozen_string_literal: true
require_relative '../lib/crab_core'

namespace :db do
  desc "Setup database"
  task :setup do
    db = CrabCore::Repository.connection
    db.create_table :dictionary do
      primary_key :id
      String :word
    end
    db.run("CREATE UNIQUE INDEX index_dictionary_on_word ON dictionary (word);")
    puts "Dictionary table created"
  end
end
