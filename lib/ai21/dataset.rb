# frozen_string_literal: true

module AI21
  class Dataset
    def list
      AI21::Client.get("/dataset")
    end

    def get(id)
      AI21::Client.get("/dataset/#{id}")
    end

    def create(name, file)
      # TODO: create dataset endpoint
    end

    def delete(id)
      AI21::Client.delete("/dataset/#{id}")
    end
  end
end
