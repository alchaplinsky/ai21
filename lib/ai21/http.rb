# frozen_string_literal: true

require "uri"
require "net/http"
require "openssl"
require "json"

module AI21
  module HTTP
    include AI21::Helper

    def get(path)
      fetch(path, :get)
    end

    def post(path, body)
      fetch(path, :post, body)
    end

    def delete(path)
      fetch(path, :delete)
    end

    def fetch(path, method, body = nil)
      url = url(path)
      http = http(url)
      request = request(url, method)

      request.body = body.to_json if body

      body = http.request(request).read_body
      camel_to_snake ::JSON.parse(body)
    end

    def request(url, method)
      request = Object.const_get("Net::HTTP::#{method.capitalize}").new(url)
      request["accept"] = content_type
      request["content-type"] = content_type
      request["Authorization"] = authorization
      request
    end

    def url(path)
      URI("#{AI21.configuration.uri_base}#{AI21.configuration.api_version}#{path}")
    end

    def http(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http
    end

    def authorization
      "Bearer #{AI21.configuration.access_token}"
    end

    def content_type
      "application/json"
    end
  end
end
