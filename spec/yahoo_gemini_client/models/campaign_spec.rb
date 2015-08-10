require 'spec_helper'

module YahooGeminiClient
  describe Campaign do
    describe "initialization" do
      subject do
        described_class.new(campaign_params)
      end

      let(:campaign_params) do
        {
          "id" => 31336,
          "status" =>"PAUSED",
          "campaignName" =>"NativeAdsCampaign",
          "budget" => 3000,
          "language" => "en",
          "budgetType" => "LIFETIME",
          "advertiserId" => 2222222,
          "channel" =>"NATIVE",
          "objective" => "PROMOTE_BRAND",
          "isPartnerNetwork" => "TRUE",
          "defaultLandingUrl" => "http://example.com",
          "trackingPartner" => "trackingPartner",
          "appLocale" => "en-us"
        }
      end

      its(:id) { is_expected.to eq 31336 }
      its(:status) { is_expected.to eq "PAUSED" }
      its(:name) { is_expected.to eq "NativeAdsCampaign" }
      its(:budget) { is_expected.to eq 3000 }
      its(:language) { is_expected.to eq "en" }
      its(:budget_type) { is_expected.to eq "LIFETIME" }
      its(:advertiser_id) { is_expected.to eq 2222222 }
      its(:channel) { is_expected.to eq "NATIVE" }
      its(:objective) { is_expected.to eq "PROMOTE_BRAND" }
      its(:is_partner_network) { is_expected.to eq "TRUE" }
      its(:default_landing_url) { is_expected.to eq "http://example.com" }
      its(:tracking_partner) { is_expected.to eq "trackingPartner" }
      its(:app_locale) { is_expected.to eq "en-us" }
      its(:to_params_hash) { is_expected.to eq(campaign_params) }

      context "parameter keys are snake_cased and symbols" do
        let(:campaign_params) do
          {
            :id => 31336,
            :status =>"PAUSED",
            :campaign_name =>"NativeAdsCampaign",
            :budget => 3000,
            :language => "en",
            :budget_type => "LIFETIME",
            :advertiser_id => 2222222,
            :channel =>"NATIVE",
            :objective => "PROMOTE_BRAND",
            :is_partner_network => "TRUE",
            :defaultLandingUrl => "http://example.com",
            :trackingPartner => "trackingPartner",
            :appLocale => "en-us",
          }
        end


        its(:id) { is_expected.to eq 31336 }
        its(:status) { is_expected.to eq "PAUSED" }
        its(:name) { is_expected.to eq "NativeAdsCampaign" }
        its(:budget) { is_expected.to eq 3000 }
        its(:language) { is_expected.to eq "en" }
        its(:budget_type) { is_expected.to eq "LIFETIME" }
        its(:advertiser_id) { is_expected.to eq 2222222 }
        its(:channel) { is_expected.to eq "NATIVE" }
        its(:objective) { is_expected.to eq "PROMOTE_BRAND" }
        its(:is_partner_network) { is_expected.to eq "TRUE" }
        its(:default_landing_url) { is_expected.to eq "http://example.com" }
        its(:tracking_partner) { is_expected.to eq "trackingPartner" }
        its(:app_locale) { is_expected.to eq "en-us" }

      end
    end

  end
end
