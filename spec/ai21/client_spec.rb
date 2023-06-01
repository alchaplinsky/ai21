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

  describe "#paraphrase" do
    let(:text) { "text input to paraphrase" }

    context "with text only" do
      subject { client.paraphrase(text) }

      it "sends text to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/paraphrase"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"text\":\"text input to paraphrase\"}")
      end
    end

    context "with options" do
      subject { client.paraphrase(text, start_index: 0, end_index: 32) }

      it "sends text and options to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/paraphrase"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"text\":\"text input to paraphrase\",\"startIndex\":0,\"endIndex\":32}")
      end
    end
  end

  describe "#correct" do
    let(:text) { "text input to correct" }

    subject { client.correct(text) }

    it "sends text to the API" do
      subject
      expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/gec"))
      expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
      expect(request).to have_received(:body=).with("{\"text\":\"text input to correct\"}")
    end
  end

  describe "#improvements" do
    let(:text) { "text input to improve" }

    context "with text only" do
      subject { client.improvements(text) }

      it "sends text to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/improvements"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"text\":\"text input to improve\",\"types\":[\"fluency\"]}")
      end
    end

    context "with text and types" do
      subject { client.improvements(text, ["vocabulary/variety"]) }

      it "sends text and options to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/improvements"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"text\":\"text input to improve\",\"types\":[\"vocabulary/variety\"]}")
      end
    end
  end

  describe "#summarize" do
    let(:text) { "text input to summarize" }

    context "with text only" do
      subject { client.summarize(text) }

      it "sends text to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/summarize"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"source\":\"text input to summarize\",\"sourceType\":\"TEXT\"}")
      end
    end

    context "with text and source type" do
      subject { client.summarize(text, "TEXT") }

      it "sends text and options to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/summarize"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"source\":\"text input to summarize\",\"sourceType\":\"TEXT\"}")
      end
    end
    context "with text, source type and option" do
      subject { client.summarize(text, "TEXT", focus: "text") }

      it "sends text and options to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/summarize"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"source\":\"text input to summarize\",\"sourceType\":\"TEXT\",\"focus\":\"text\"}")
      end
    end
  end

  describe "#segmentation" do
    let(:text) { "text input" }

    context "with text only" do
      subject { client.segmentation(text) }

      it "sends text to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/segmentation"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"source\":\"text input\",\"sourceType\":\"TEXT\"}")
      end
    end

    context "with text and source type" do
      subject { client.segmentation(text, "TEXT") }

      it "sends text and options to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/segmentation"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"source\":\"text input\",\"sourceType\":\"TEXT\"}")
      end
    end
  end

  describe "#answer" do
    let(:question) { "what day is today?" }
    let(:context) { "Today is 1st of June 2023" }

    context "with text only" do
      subject { client.answer(question, context) }

      it "sends question and context to the API" do
        subject
        expect(Net::HTTP::Post).to have_received(:new).with(URI("https://api.ai21.com/studio/v1/experimental/answer"))
        expect(request).to have_received(:[]=).with("Authorization", "Bearer #{token}")
        expect(request).to have_received(:body=).with("{\"question\":\"what day is today?\",\"context\":\"Today is 1st of June 2023\"}")
      end
    end
  end
end
