require 'doorkeeper/request'
require 'doorkeeper/config'

module DoorkeeperScopesPerFlow
  class Engine < Rails::Engine
    require 'activesupport-decorators'
    initializer :set_decorator_paths, :before => :load_environment_hook do |app|
      ActiveSupportDecorators.paths << File.join(config.root, 'app/decorators/**')
    end
  end
end

module Doorkeeper
  class Config
    class Builder
      def scopes_flows_whitelist(*scopes_flows_map)
        @config.instance_variable_set('@scopes_flows_whitelist', scopes_flows_map)
      end

      def flows_default_scopes(*flows_defaults)
        @config.instance_variable_set('@flows_default_scopes', flows_defaults)
      end
    end

    extend Option
    option :scopes_flows_whitelist, default: nil
    option :flows_default_scopes, default: nil
    attr_reader :scopes_flows_whitelist, :flows_default_scopes
  end

  module Request
    module_function

    def authorization_strategy(response_type, scopes)
      get_strategy response_type, authorization_response_types, scopes
    rescue NameError
      raise Errors::InvalidAuthorizationStrategy
    end

    def token_strategy(grant_type, scopes)
      get_strategy grant_type, token_grant_types, scopes
    rescue NameError
      raise Errors::InvalidTokenStrategy
    end

    def get_strategy(grant_or_request_type, available, scopes)
      fail Errors::MissingRequestStrategy unless grant_or_request_type.present?
      fail NameError unless available.include?(grant_or_request_type.to_s)
      if !scopes_flows_whitelist.nil?
        scopes.nil? || scopes.split(" ").each do |scope|
          scope = scope.to_sym
          fail Errors::DoorkeeperError, "Specified scope not allowed" unless scopes_flows_whitelist.has_key?(scope)
          fail Errors::DoorkeeperError, "Scope '#{scope}' not allowed for '#{grant_or_request_type}' grant_type" unless (scopes_flows_whitelist[scope].include?(grant_or_request_type.to_sym) or scopes_flows_whitelist[scope].include?(:all))
        end
      end
      "Doorkeeper::Request::#{grant_or_request_type.to_s.camelize}".constantize
    end

    def scopes_flows_whitelist
      Doorkeeper.configuration.scopes_flows_whitelist
    end
  end

  class Server
    attr_accessor :context
    def token_request(strategy, scopes=nil)
      klass = Request.token_strategy strategy, scopes
      klass.new self
    end

    def authorization_request(strategy, scopes=nil)
      klass = Request.authorization_strategy strategy, scopes
      klass.new self
    end
  end
end
