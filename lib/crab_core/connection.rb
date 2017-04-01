# frozen_string_literal: true
require 'yaml'
require 'sequel'
require 'logger'

class CrabCore
  class ConfigurationError < CrabCoreError; end

  class Connection
    class << self
      def connection
        @connection ||= Sequel.connect(
          "#{config['adapter']}://#{config['username']}@#{config['host']}:#{config['port']}/#{config['database']}")
      end

      def connection_without_database
        @connection ||= Sequel.connect(
          "#{config['adapter']}://#{config['username']}@#{config['host']}:#{config['port']}/")
      end

      def close
        @connection.disconnect
        @connection = nil
      end

      def config
        return @config if @config

        file = File.expand_path('config/database.yml')
        raise ConfigurationError, "Database configure file not found #{file}" unless File.exists?(file)

        @config = YAML.load_file(file)[ENV['RACK_ENV'] || 'development']
      end
    end
  end
end
