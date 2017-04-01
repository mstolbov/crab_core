# frozen_string_literal: true
require_relative '../lib/crab_core'

namespace :app do
  desc "Import dictionary"
  task :import, [:path] do |t, args|
    db = CrabCore::Repository.connection
    dictionary = db[:dictionary]
    File.read(args[:path]).each_line do |word|
      dictionary.insert(word: word.strip)
    end
    puts "Dictionary imported"
  end
end
