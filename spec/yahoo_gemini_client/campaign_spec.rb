require 'spec_helper'

module YahooGeminiClient
  describe Campaign do
    describe "initialization" do
      subject do
        described_class.new(
          "id" => 31336,
          "status" =>"PAUSED",
          "campaignName" =>"NativeAdsCampaign",
          "budget" => 3000,
          "language" => "en",
          "budgetType" => "LIFETIME",
          "advertiserId" => 2222222,
          "channel" =>"NATIVE",
          "objective" => "PROMOTE_BRAND",
          "isPartnerNetwork" => "TRUE"
        )
      end

      its(:id) { is_expected.to eq 31336 }
      its(:status) { is_expected.to eq "PAUSED" }
      its(:campaign_name) { is_expected.to eq "NativeAdsCampaign" }
      its(:budget) { is_expected.to eq 3000 }
      its(:language) { is_expected.to eq "en" }
      its(:budget_type) { is_expected.to eq "LIFETIME" }
      its(:advertiser_id) { is_expected.to eq 2222222 }
      its(:channel) { is_expected.to eq "NATIVE" }
      its(:objective) { is_expected.to eq "PROMOTE_BRAND" }
      its(:is_partner_network) { is_expected.to eq "TRUE" }
    end
  end
end
