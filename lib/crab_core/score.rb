# frozen_string_literal: true
require 'json'

class CrabCore
  class Score
    def initialize(word)
      @word = word
    end

    def call
      failure
    end

    private

    def success
      { word: @word, valid: true, score: 10 }.to_json
    end

    def failure
      { word: @word, valid: false }.to_json
    end
  end
end
