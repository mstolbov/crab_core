# frozen_string_literal: true
require_relative 'test_helper'

class TestCrabCore < Minitest::Test
  def setup
    @request = Rack::MockRequest.new(CrabCore)
    CrabCore::Dictionary.all.map(&:delete)
  end

  def test_display_welcom_message
    response = @request.get('/')
    assert_equal 200, response.status
    assert_equal "Welcome To Crab Core! It's a simple Scrabble Scorer service.", response.body
  end

  def test_not_found
    response = @request.get('/something')
    assert_equal 404, response.status
    assert_equal "Not Found", response.body
  end

  def test_bad_request
    response = @request.get('/score/!!')
    assert_equal 502, response.status
    assert_equal "Bad Request", response.body
  end

  def test_found_score
    record = CrabCore::Dictionary.create('fish')
    response = @request.get('/score/fish')
    record.delete
    expected_body = { word: "fish", valid: true, score: 10 }.to_json
    assert_equal 200, response.status
    assert_equal expected_body, response.body
  end

  def test_not_found_score
    response = @request.get('/score/fish')
    expected_body = { word: "fish", valid: false }.to_json
    assert_equal 200, response.status
    assert_equal expected_body, response.body
  end
end
