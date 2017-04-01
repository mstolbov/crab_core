# frozen_string_literal: true
class CrabCore
  class WordNotFound < CrabCoreError; end

  class Dictionary
    class << self
      def find!(word)
        result = repository[word: word]
        raise WordNotFound unless result
        new(id: result.id, word: result.word)
      end

      def contains?(word)
        !!repository[word: word]
      end

      def create(word)
        id = repository.insert(word: word.upcase)
        new(id: id, word: word)
      end

      def delete(id)
        repository.where(id: id).delete
      end

      def all
        repository.all.map { |res| new(res) }
      end

      private

      def repository
        @repository ||= CrabCore::Repository.connection[:dictionary]
      end
    end

    attr_reader :id, :word

    def initialize(id:, word:)
      @id = id
      @word = word
    end

    def delete
      self.class.delete(id)
    end
  end
end
