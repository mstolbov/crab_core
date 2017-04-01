# frozen_string_literal: true
class CrabCore
  class CrabCoreError < StandardError; end

  def self.call(env)
    new(env).().finish
  end

  def initialize(env)
    @request = Rack::Request.new(env)
  end

  def call
    case @request.path
    when '/'
      welcome
    when '/42'
      forty_two
    when %r{/score(.*)}i
      score $1
    else
      not_found
    end
  end

  private

  def welcome
    response "Welcome To Crab Core! It's a simple Scrabble Scorer service."
  end

  def forty_two
    response "Answer to the Ultimate Question of Life, the Universe, and Everything"
  end

  def score(word)
    case word
    when %r{/(\w+)$}i
      response Scorer.($1)
    else
      bad_request
    end
  end

  def response(obj)
    Rack::Response.new(obj)
  end

  def not_found
    Rack::Response.new("Not Found", 404)
  end

  def bad_request
    Rack::Response.new("Bad Request", 502)
  end
end

require_relative 'crab_core/scorer'
require_relative 'crab_core/dictionary'
require_relative 'crab_core/connection'
