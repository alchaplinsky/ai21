# frozen_string_literal: true

require_relative "../../lib/ai21/helper"

RSpec.describe AI21::Helper do
  include AI21::Helper

  let(:object) do
    {
      "foo" => "bar",
      "baz" => {
        "one" => 1,
        "array" => [
          {
            "two" => 2
          }
        ]
      }
    }
  end

  describe ".deep_transform_keys!" do
    let(:block) { proc { |key| key.reverse } }

    subject { deep_transform_keys!(object, &block) }

    it "transforms nested keys" do
      expect(subject).to eq({
        "oof" => "bar",
        "zab" => {
          "eno" => 1,
          "yarra" => [
            {
              "owt" => 2
            }
          ]
        }
      })
    end
  end

  describe ".camel_to_snake" do
    subject { camel_to_snake(object) }

    context "with string keys" do
      let(:object) do
        {
          "firstName" => "John",
          "peronalInfo" => {
            "totalScore" => 35,
            "accountsTotal" => [
              {"accountName" => "one"},
              {"accountName" => "two"}
            ]
          }
        }
      end

      it "transforms keys to snake case symbols" do
        expect(subject).to eq({
          first_name: "John",
          peronal_info: {
            total_score: 35,
            accounts_total: [
              {account_name: "one"},
              {account_name: "two"}
            ]
          }
        })
      end
    end

    context "with symbol keys" do
      let(:object) do
        {
          firstName: "John",
          peronalInfo: {
            totalScore: 35,
            accountsTotal: [
              {accountName: "one"},
              {accountName: "two"}
            ]
          }
        }
      end

      it "transforms keys to snake case symbols" do
        expect(subject).to eq({
          first_name: "John",
          peronal_info: {
            total_score: 35,
            accounts_total: [
              {account_name: "one"},
              {account_name: "two"}
            ]
          }
        })
      end
    end
  end

  describe ".snake_to_camel" do
    subject { snake_to_camel(object) }

    context "with string keys" do
      let(:object) do
        {
          "first_name" => "John",
          "peronal_info" => {
            "total_score" => 35,
            "accounts_total" => [
              {"account_name" => "one"},
              {"account_name" => "two"}
            ]
          }
        }
      end

      it "transforms keys to camel case symbols" do
        expect(subject).to eq({
          firstName: "John",
          peronalInfo: {
            totalScore: 35,
            accountsTotal: [
              {accountName: "one"},
              {accountName: "two"}
            ]
          }
        })
      end
    end

    context "with symbol keys" do
      let(:object) do
        {
          first_name: "John",
          peronal_info: {
            total_score: 35,
            accounts_total: [
              {account_name: "one"},
              {account_name: "two"}
            ]
          }
        }
      end

      it "transforms keys to camel case symbols" do
        expect(subject).to eq({
          firstName: "John",
          peronalInfo: {
            totalScore: 35,
            accountsTotal: [
              {accountName: "one"},
              {accountName: "two"}
            ]
          }
        })
      end
    end
  end
end
