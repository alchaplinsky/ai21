# frozen_string_literal: true

RSpec.describe AI21::Dataset do
  let(:token) { "API_TOKEN" }
  let(:client) { AI21::Client.new token }
  let(:http) { double("Net::HTTP") }
  let(:request) { double("Net::HTTP::Get") }

  before do
    allow(http).to receive(:request).and_return(OpenStruct.new(read_body: "{\"success\": true}"))
    allow(http).to receive(:use_ssl=).with(true)
    allow(request).to receive(:[]=)
    allow(request).to receive(:body=)
    allow(Net::HTTP).to receive(:new).and_return(http)
    allow(Net::HTTP::Get).to receive(:new).and_return(request)
  end

  describe "#list" do
    subject { client.dataset.list }

    it "returns a list of datasets" do
      subject
      expect(Net::HTTP::Get).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/dataset"))
      expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
    end
  end

  describe "#get" do
    subject { client.dataset.get(1) }

    it "returns a dataset" do
      subject
      expect(Net::HTTP::Get).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/dataset/1"))
      expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
    end
  end

  describe "#create" do
  end

  describe "#delete" do
    let(:request) { double("Net::HTTP::Delete") }

    before do
      allow(request).to receive(:[]=)
      allow(Net::HTTP::Delete).to receive(:new).and_return(request)
    end

    subject { client.dataset.delete(1) }

    it "returns a dataset" do
      subject
      expect(Net::HTTP::Delete).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/dataset/1"))
      expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
    end
  end
end
