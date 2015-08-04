require "spec_helper"

module YahooGeminiClient
  describe Advertisers do
    let(:client) do
      client = Client.new(
        consumer_key: consumer_key,
        consumer_secret: consumer_secret,
      )
      client.get_token(authorization_code)
      client
    end
    let(:consumer_key) { ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"] }
    let(:consumer_secret) { ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"] }
    let(:authorization_code) { ENV["YAHOO_GEMINI_TEST_AUTHORIZATION_CODE"] }

    describe "#find", vcr: { record: :once } do
      let(:advertisers_to_find) { client.advertisers.to_a[0..1] }

      it "looks for advertisers matching given id/s" do
        advertisers = described_class.new(client: client).
          find(advertisers_to_find.map(&:id))

        expect(advertisers.count).to eq 2
        expect(advertisers[0].advertiser_name).
          to eq advertisers_to_find[0].advertiser_name
        expect(advertisers[1].advertiser_name).
          to eq advertisers_to_find[1].advertiser_name
      end
    end
  end
end
