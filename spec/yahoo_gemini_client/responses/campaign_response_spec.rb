require 'spec_helper'

module YahooGeminiClient
  describe CampaignResponse do
    let(:csv_url) { "https://nads.zenfs.com/nads/reportGeneration/14388194548561824a6b77245dc0efb49b68ddee56afeb83f8baa.csv" }
    let(:job_id) { "job_id" }
    let(:timestamp) { "2015-08-05 4:16:19" }
    let(:campaigns_hashes) {
      [{
        "campaignName" => "[non-year] dynamic used inventory",
        "status" => "PAUSED",
        "objective" => "VISIT_WEB",
        "id" => 341715003,
        "budgetType" => "DAILY",
        "budget" => 5,
        "advertiserId" => 1643871,
        "language" => "en",
        "isPartnerNetwork" => "TRUE",
        "channel" => "SEARCH"
      },{
        "campaignName" => "[year] dynamic used inventory",
        "status" => "PAUSED",
        "objective" => "VISIT_WEB",
        "id" => 341715004,
        "budgetType" => "DAILY",
        "budget" => 5,
        "advertiserId" => 1643871,
        "language" => "en",
        "isPartnerNetwork" => "TRUE",
        "channel" => "SEARCH"
      },{
        "campaignName" => "New Cars",
        "status" => "ACTIVE",
        "objective" => "VISIT_WEB",
        "id" => 341715005,
        "budgetType" => "DAILY",
        "budget" => 15,
        "advertiserId" => 1643871,
        "language" => "en",
        "isPartnerNetwork" => "TRUE",
        "channel" => "SEARCH"
      }]
    }

    context "completed" do
      let(:response) do
        CampaignResponse.new(
          {
            errors: nil,
            timestamp: timestamp,
            response: campaigns_hashes
          }
        )
      end

      subject{ response }

      its(:error?) { is_expected.to be_falsey }
      specify do
        expect(subject.campaigns).to be_a Array
        expect(subject.campaigns.first).to be_a YahooGeminiClient::Campaign
      end
    end
  end
end
