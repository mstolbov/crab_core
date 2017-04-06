# frozen_string_literal: true
require 'json'

class CrabCore
  class Scorer
    WORTH = {
      'A' => 1, 'B' => 3, 'C' => 3, 'D' => 2, 'E' => 1, 'F' => 4, 'G' => 2,
      'H' => 4, 'I' => 1, 'J' => 8, 'K' => 5, 'L' => 1, 'M' => 3, 'N' => 1,
      'O' => 1, 'P' => 3, 'Q' => 10, 'R' => 1, 'S' => 1, 'T' => 1, 'U' => 1,
      'V' => 4, 'W' => 4, 'X' => 8, 'Y' => 4, 'Z' => 10
    }.freeze

    def self.call(word)
      new(word).()
    end

    attr_reader :word

    def initialize(word)
      @word = word
    end

    def call
      if Dictionary.contains?(word)
        success
      else
        failure
      end
    end

    def score
      score = 0
      word.each_char { |c| score += WORTH[c.upcase] }
      score
    end

    private

    def success
      { word: word, valid: true, score: score }.to_json
    end

    def failure
      { word: word, valid: false }.to_json
    end
  end
end
