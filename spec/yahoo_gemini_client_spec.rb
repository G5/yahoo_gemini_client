require 'spec_helper'

RSpec.describe YahooGeminiClient do

  describe ".new" do
    let(:client) { double(YahooGeminiClient::Client) }
    let(:args) { {a: "b"} }

    it "returns a YahooGeminiClient::Client" do
      expect(YahooGeminiClient::Client).to receive(:new).with(args).
        and_return(client)

      expect(described_class.new(args)).to eq client
    end
  end

end
