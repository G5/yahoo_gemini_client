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
      let(:campaign_params) do
        {
          "status" =>"PAUSED",
          "campaignName" =>"NativeAdsCampaign",
          "budget" => 3000,
          "language" => "en",
          "budgetType" => "LIFETIME",
          "advertiserId" => advertiser_id,
          "channel" =>"NATIVE",
          "objective" => "PROMOTE_BRAND",
          "isPartnerNetwork" => "TRUE"
        }
      end

      it "creates a campaign with the given parameters" do
        campaign = client.campaigns.create(campaign_params)
        expect(campaign.id).to be > 0
        expect(campaign.language).to eq "en"
        expect(campaign.budget).to eq 3000
        expect(campaign.campaign_name).to eq "NativeAdsCampaign"
      end

      context "parameter keys are snake_cased and symbols" do
        let(:campaign_params) do
          {
            :status =>"PAUSED",
            :campaign_name =>"NativeAdsCampaign",
            :budget => 3000,
            :language => "en",
            :budget_type => "LIFETIME",
            :advertiser_id => advertiser_id,
            :channel =>"NATIVE",
            :objective => "PROMOTE_BRAND",
            :is_partner_network => "TRUE"
          }
        end

        it "creates a campaign" do
          campaign = client.campaigns.create(campaign_params)
          expect(campaign.id).to be > 0
          expect(campaign.language).to eq "en"
          expect(campaign.budget).to eq 3000
          expect(campaign.campaign_name).to eq "NativeAdsCampaign"
        end
      end
    end

    describe "#where", vcr: { record: :all } do
      # assumes there are at least 2 campaigns created already
      let(:campaigns_to_find) { client.campaigns.to_a[0..1] }

      it "gives the campaign given the :id" do
        resulting_campaign = described_class.new(client: client).
          where(id: campaigns_to_find.first.id)

        expect(resulting_campaign.campaign_name).
          to eq campaigns_to_find[0].campaign_name
      end

      context ":id parameter is an array of ids" do
        it "looks for campaigns matching given id/s" do
          campaigns = described_class.new(client: client).
            where(id: campaigns_to_find.map(&:id))

          expect(campaigns.count).to eq 2
          expect(campaigns[0].campaign_name).
            to eq campaigns_to_find[0].campaign_name
          expect(campaigns[1].campaign_name).
            to eq campaigns_to_find[1].campaign_name
        end
      end
    end

  end
end
