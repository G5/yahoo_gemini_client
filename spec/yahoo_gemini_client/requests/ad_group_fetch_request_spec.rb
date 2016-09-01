require 'spec_helper'

module YahooGeminiClient
  describe AdGroupFetchRequest do
    let(:client) do
      Client.new(
        consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
        consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
        refresh_token: ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"],
      )
    end

    describe "#execute" do
      context "success", :vcr => { :record => :once } do
        let(:ad_group_id) { 12345 }

        subject do
          AdGroupFetchRequest.new({
            client: client,
            ad_group_id: ad_group_id
          })
        end

        it "returns a AdGroupResponse object" do
          response = subject.execute
          expect(response).to be_a AdGroupResponse
          expect(response.ad_group.id).to eq 12345
          expect(response.error?).to be_falsey
        end
      end
    end
  end
end
