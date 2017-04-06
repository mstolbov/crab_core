# frozen_string_literal: true
require_relative 'repository/connection'

class CrabCore
  class Repository
    class NotFound < ::CrabCore::CrabCoreError; end

    def initialize(table)
      @table = table
    end

    def all
      Connection.() { |c| c[@table].all }
    end

    def find(id)
      result = Connection.() { |c| c[@table][id: id] }
      raise NotFound unless result
      result
    end

    def where(condition)
      Connection.() { |c| c[@table][condition] }
    end

    def create(params)
      Connection.() { |c| c[@table].insert(params) }
    end

    def delete(id)
      Connection.() { |c| c[@table].where(id: id).delete }
    end
  end
end
