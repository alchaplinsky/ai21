# frozen_string_literal: true

module AI21
  class Client
    extend AI21::HTTP

    def initialize(access_token)
      AI21.configuration.access_token = access_token if access_token
    end

    def complete(prompt, options = {})
      model = options.delete(:model) || AI21::Complete::DEFALUT_COMPLETE_MODEL

      AI21::Complete.call(prompt, model, options)
    end

    def instruct(prompt, options = {})
      model = options.delete(:model) || AI21::Complete::DEFAULT_INSTRUCT_MODEL

      AI21::Complete.call(prompt, model, options)
    end

    def datasets
      @datasets ||= AI21::Dataset.new
    end
  end
end
