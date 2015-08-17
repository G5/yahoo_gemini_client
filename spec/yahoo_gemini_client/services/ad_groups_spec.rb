require 'spec_helper'

module YahooGeminiClient
  describe AdGroups do
    let(:ad_group_id) { 12345 }
    let(:client) do
      Client.new(
        consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
        consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
        token: {
          refresh_token: ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"],
        }
      )
    end

    describe "#find" do
      let(:id) { ad_group_id }

      let(:request) { instance_double("AdGroupFetchRequest") }
      let(:response) { instance_double("AdGroupResponse") }

      it "sends a request to Yahoo to fetch data of an ad_group" do
        params = { ad_group_id: id }
        expect(AdGroupFetchRequest).
          to receive(:new).
          with(params.merge(client: client)).
          and_return(request)
        expect(request).to receive(:execute).and_return(response)
        described_class.new(client: client).find(id)
      end
    end
  end
end
