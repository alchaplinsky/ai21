# frozen_string_literal: true

require_relative "ai21/version"
require_relative "ai21/helper"
require_relative "ai21/http"
require_relative "ai21/client"
require_relative "ai21/dataset"
require_relative "ai21/custom_model"

module AI21
  class Error < StandardError; end

  class ConfigurationError < Error; end

  class Configuration
    attr_writer :access_token
    attr_accessor :api_version, :uri_base

    def initialize
      @access_token = nil
      @uri_base = "https://api.ai21.com/studio/"
      @api_version = "v1"
    end

    def access_token
      return @access_token if @access_token

      error_text = "AI21 access token is missing. Visit https://studio.ai21.com/account"
      raise ConfigurationError, error_text
    end
  end

  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
