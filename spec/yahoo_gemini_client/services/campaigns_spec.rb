require 'spec_helper'

module YahooGeminiClient
  describe Campaigns do
    let(:advertiser_id) { 12345 }
    let(:client) do
      Client.new(
        consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
        consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
        token: {
          refresh_token: ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"],
        }
      )
    end

    describe "#where" do
      let(:params) {
        {
          advertiser_id: advertiser_id,
        }
      }

      let(:request) { instance_double("CampaignFetchRequest") }
      let(:response) { instance_double("CampaignResponse") }

      it "sends a request to Yahoo to fetch all campaigns for an advertiser" do
        expect(CampaignFetchRequest).
          to receive(:new).
          with(params.merge(client: client)).
          and_return(request)
        expect(request).to receive(:execute).and_return(response)
        described_class.new(client: client).where(params)
      end
    end
  end
end
