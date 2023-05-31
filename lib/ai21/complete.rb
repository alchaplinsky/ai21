# frozen_string_literal: true

module AI21
  module Complete
    extend AI21::Helper

    DEFALUT_COMPLETE_MODEL = "j2-grande"
    DEFAULT_INSTRUCT_MODEL = "j2-grande-instruct"

    def self.call(prompt, model, options = {})
      response = AI21::Client.post("/#{model}/complete", {prompt: prompt}.merge(snake_to_camel(options)))
      camel_to_snake(response)
    end
  end
end
