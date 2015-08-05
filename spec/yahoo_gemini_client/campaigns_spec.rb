require "spec_helper"

module YahooGeminiClient
  describe Campaigns do

    let(:client) do
      client = Client.new(
        consumer_key: consumer_key,
        consumer_secret: consumer_secret,
        token: { refresh_token: refresh_token },
      )
      client.token_refresh!
      client
    end
    let(:consumer_key) { ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"] }
    let(:consumer_secret) { ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"] }
    let(:refresh_token) { ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"] }

    describe "#all", vcr: { record: :once } do
      it "returns all campaigns" do
        campaigns = client.campaigns.all

        expect(campaigns.count).to be > 0

        # elements are campaigns
        expect(campaigns.first.id).to be > 0
        expect(campaigns.first.language).to eq "en"
        expect(campaigns.first.budget).to be > 0
        expect(campaigns.first.status).to eq "PAUSED"
      end
    end

    describe "#create", vcr: { record: :once } do
      let(:advertisers) { client.advertisers }
      let(:advertiser_id) { advertisers.first.id }

      it "creates a campaign with the given parameters" do
        campaign = client.campaigns.create(
          "status" =>"PAUSED",
          "campaignName" =>"NativeAdsCampaign",
          "budget" => 3000,
          "language" => "en",
          "budgetType" => "LIFETIME",
          "advertiserId" => advertiser_id,
          "channel" =>"NATIVE",
          "objective" => "PROMOTE_BRAND",
          "isPartnerNetwork" => "TRUE"
        )
        expect(campaign.id).to be > 0
        expect(campaign.language).to eq "en"
        expect(campaign.budget).to eq 3000
        expect(campaign.campaign_name).to eq "NativeAdsCampaign"
      end
    end

  end
end
