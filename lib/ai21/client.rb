# frozen_string_literal: true

module AI21
  class Client
    include AI21::Helper
    extend AI21::HTTP

    DEFALUT_COMPLETE_MODEL = "j2-grande"
    DEFAULT_INSTRUCT_MODEL = "j2-grande-instruct"

    def initialize(access_token)
      AI21.configuration.access_token = access_token if access_token
    end

    def complete(prompt, options = {})
      model = options.delete(:model) || DEFALUT_COMPLETE_MODEL

      AI21::Client.post("/#{model}/complete", {prompt: prompt}.merge(snake_to_camel(options)))
    end

    def instruct(prompt, options = {})
      model = options.delete(:model) || DEFAULT_INSTRUCT_MODEL

      AI21::Client.post("/#{model}/complete", {prompt: prompt}.merge(snake_to_camel(options)))
    end

    def paraphrase(prompt, options = {})
      AI21::Client.post("/paraphrase", {text: prompt}.merge(snake_to_camel(options)))
    end

    def correct(prompt)
      AI21::Client.post("/gec", {text: prompt})
    end

    def improvements(prompt, types = ["fluency"])
      AI21::Client.post("/improvements", {text: prompt, types: types})
    end

    def summarize(prompt, source_type = "TEXT", options = {})
      AI21::Client.post("/summarize", {source: prompt, sourceType: source_type}.merge(snake_to_camel(options)))
    end

    def segmentation(prompt, source_type = "TEXT")
      AI21::Client.post("/segmentation", {source: prompt, sourceType: source_type})
    end

    def answer(question, context)
      AI21::Client.post("/experimental/answer", {question: question, context: context})
    end

    def tokenize(text)
      AI21::Client.post("/tokenize", {text: text})
    end

    def dataset
      @dataset ||= AI21::Dataset.new
    end

    def custom_model
      @custom_model ||= AI21::CustomModel.new
    end
  end
end
