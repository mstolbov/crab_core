# frozen_string_literal: true
require 'crab_core'

if ENV['RACK_ENV'] == 'development'
  use Rack::Reloader, 0
end

run CrabCore
