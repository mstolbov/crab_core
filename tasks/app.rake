# frozen_string_literal: true
require_relative '../lib/crab_core'

namespace :app do
  desc "Import dictionary"
  task :import, [:path] do |t, args|
    File.read(args[:path]).each_line do |word|
      CrabCore::Dictionary.add(word.strip)
    end
    puts "Dictionary imported"
  end
end
