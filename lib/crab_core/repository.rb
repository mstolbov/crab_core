# frozen_string_literal: true
require 'yaml'
require 'sequel'
require 'logger'

class CrabCore
  class ConfigurationError < CrabCoreError; end

  class Repository
    class << self
      def connection
        user = [ config['username'], config['password'] ].compact.join(':')
        @connection ||= Sequel.connect(
          "#{config['adapter']}://#{user}@#{config['host']}:#{config['port']}/#{config['database']}")
      end

      def connection_without_database
        user = [ config['username'], config['password'] ].compact.join(':')
        Sequel.connect(
          "#{config['adapter']}://#{user}@#{config['host']}:#{config['port']}/")
      end

      def config
        return @config if @config

        file = File.expand_path('config/database.yml')
        raise ConfigurationError, "Database configure file not found #{file}" unless File.exists?(file)

        @config = YAML.load(File.read('config/database.yml'))[ENV['RACK_ENV'] || 'development']
      end
    end
  end
end
