# frozen_string_literal: true
require 'yaml'
require 'sequel'
require 'logger'

class CrabCore
  class ConfigurationError < CrabCoreError; end

  class Repository
    class << self
      def connection
        @connection ||= Sequel.connect(
          "postgres://iwywirpvrutazo:630db5fd6c47cac81cc40a59d455517acfd150976b53ea2d7517d3d456a876b5@ec2-184-72-216-69.compute-1.amazonaws.com:5432/d89m2tqnmgkrrh")
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

        @config = YAML.safe_load(File.read('config/database.yml'))[ENV['RACK_ENV'] || 'development']
      end
    end
  end
end
