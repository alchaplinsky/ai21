# frozen_string_literal: true

require "uri"
require "net/http"
require "openssl"
require "json"
require "pry"

module AI21
  module HTTP
    include AI21::Helper

    def get(path)
      url = URI("#{AI21.configuration.uri_base}#{AI21.configuration.api_version}#{path}")
      http = http(url)
      request = get_request(url)
      body = http.request(request).read_body
      camel_to_snake ::JSON.parse(body)
    end

    def post(path, body)
      url = URI("#{AI21.configuration.uri_base}#{AI21.configuration.api_version}#{path}")
      http = http(url)
      request = post_request(url, body)
      body = http.request(request).read_body
      camel_to_snake ::JSON.parse(body)
    end

    def get_request(url)
      request = Net::HTTP::Get.new(url)
      request["accept"] = "application/json"
      request["Authorization"] = "Bearer #{AI21.configuration.access_token}"
      request
    end

    def post_request(url, body)
      request = Net::HTTP::Post.new(url)
      request["accept"] = "application/json"
      request["content-type"] = "application/json"
      request["Authorization"] = "Bearer #{AI21.configuration.access_token}"
      request.body = body.to_json
      request
    end

    def http(url)
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true
      http
    end
  end
end
