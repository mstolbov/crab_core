# frozen_string_literal: true
require 'yaml'
require 'sequel'

class CrabCore
  class Repository
    class Connection
      class ConfigurationError < CrabCore::CrabCoreError; end
      class << self
        def call(&block)
          yield connection if block_given?
        end

        private

        def connection
          @connection ||= Sequel.connect("#{config['adapter']}://#{config['database']}", {
            max_connections: config['pool'],
              timeout: config['timeout']
          })
        end

        def config
          return @config if @config

          file = File.expand_path('config/database.yml')
          raise ConfigurationError, "Database configure file not found #{file}" unless File.exists?(file)

          @config = YAML.safe_load(File.read('config/database.yml'))[ENV['RACK_ENV'] || 'development']
        end
      end
    end
  end
end
