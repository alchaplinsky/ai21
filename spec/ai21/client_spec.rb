# frozen_string_literal: true

RSpec.describe AI21::Client do
  let(:token) { "API_TOKEN" }
  let(:client) { AI21::Client.new token }
  let(:http) { double("Net::HTTP") }
  let(:request) { double("Net::HTTP::Post") }

  before do
    allow(http).to receive(:request).and_return(OpenStruct.new(read_body: "{\"success\": true}"))
    allow(http).to receive(:use_ssl=).with(true)
    allow(request).to receive(:[]=)
    allow(request).to receive(:body=)
    allow(Net::HTTP).to receive(:new).and_return(http)
    allow(Net::HTTP::Post).to receive(:new).and_return(request)
  end

  describe "#complete" do
    let(:prompt) { "Today is " }

    context "with prompt" do
      subject { client.complete(prompt) }

      it "sends prompt to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/j2-grande/complete"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"prompt\":\"Today is \"}")
      end
    end

    context "with model option" do
      subject { client.complete(prompt, model: "j2-large") }

      it "sends prompt to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/j2-large/complete"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"prompt\":\"Today is \"}")
      end
    end

    context "with model and other options" do
      subject { client.complete(prompt, model: "j2-large", temperature: 0.9, max_tokens: 16) }

      it "sends prompt to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/j2-large/complete"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"prompt\":\"Today is \",\"temperature\":0.9,\"maxTokens\":16}")
      end
    end
  end

  describe "#instruct" do
    let(:prompt) { "What is AI?" }

    context "with prompt" do
      subject { client.instruct(prompt) }

      it "sends prompt to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/j2-grande-instruct/complete"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"prompt\":\"What is AI?\"}")
      end
    end

    context "with model option" do
      subject { client.instruct(prompt, model: "j2-jumbo-instruct") }

      it "sends prompt to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/j2-jumbo-instruct/complete"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"prompt\":\"What is AI?\"}")
      end
    end

    context "with model and other options" do
      subject { client.instruct(prompt, model: "j2-jumbo-instruct", temperature: 0.9, max_tokens: 16) }

      it "sends prompt to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/j2-jumbo-instruct/complete"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"prompt\":\"What is AI?\",\"temperature\":0.9,\"maxTokens\":16}")
      end
    end
  end
end
