# frozen_string_literal: true
class CrabCore
  class Dictionary
    class << self
      def add(word)
        word = word.upcase
        id = repository.create(word: word)
        new(id: id, word: word)
      end

      def remove(word)
        record = repository.find(word: word)
        repository.delete(record[:id])
      end

      def contains?(word)
        !!repository.where(word: word.upcase)
      end

      private

      def repository
        @repository ||= CrabCore::Repository.new(:dictionary)
      end
    end

    attr_reader :id, :word

    def initialize(id:, word:)
      @id = id
      @word = word
    end
  end
end
