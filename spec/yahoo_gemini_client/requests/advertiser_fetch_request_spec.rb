require 'spec_helper'

module YahooGeminiClient
  describe AdvertiserFetchRequest do
    let(:client) do
      Client.new(
        consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
        consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
        token: {
          refresh_token: ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"],
        }
      )
    end

    describe "#execute" do
      context "success", :vcr => { :record => :once} do
        let(:advertiser_id) { 1086524 }

        subject do
          AdvertiserFetchRequest.new({
            client: client,
            advertiser_id: advertiser_id
          })
        end

        it "returns a CampaignResponse object" do
          response = subject.execute
          expect(response).to be_a AdvertiserResponse
          expect(response.error?).to be_falsey
        end
      end
    end
  end
end
