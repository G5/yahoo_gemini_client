require 'spec_helper'

module YahooGeminiClient
  describe AdvertisersFetchRequest do
    let(:client) do
      Client.new(
        consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
        consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
        refresh_token: ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"],
      )
    end

    describe "#execute" do
      context "success", :vcr => { :record => :once} do
        subject do
          AdvertisersFetchRequest.new({
            client: client,
          })
        end

        it "returns a AdvertisersResponse object" do
          response = subject.execute
          expect(response).to be_a AdvertisersResponse
          expect(response.advertisers.first.class).to eq YahooGeminiClient::Advertiser
          expect(response.error?).to be_falsey
        end
      end
    end
  end
end
