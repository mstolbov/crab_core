# frozen_string_literal: true
ENV['RACK_ENV'] = 'test'

require 'coveralls'
Coveralls.wear!

require 'rack'
require 'json'
require 'minitest/autorun'
require_relative '../lib/crab_core'
