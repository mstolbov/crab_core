#!/usr/bin/env rake
# frozen_string_literal: true
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*_test.rb']
  t.verbose = true
end

task :default => :test

Dir.glob("tasks/**/*.rake").each { |r| load r }

