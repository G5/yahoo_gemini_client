require 'spec_helper'

module YahooGeminiClient
  describe AdvertiserResponse do
    let(:timestamp) { "2015-08-05 4:16:19" }
    let(:advertiser_hash) {
      {
        "errors" => nil,
        "timestamp" => "2015-08-11 5:26:26",
        "response" => {
          "type" => "ADVERTISER",
          "status" => "ACTIVE",
          "currency" => "USD",
          "id" => 1086524,
          "timezone" => "America\/Chicago",
          "bookingCountry" => "US",
          "billingCountry" => "US",
          "managedBy" => 1032936,
          "language" => "en",
          "advertiserName" => "HRA - Honda San Marcos"
        }
      }
    }

    context "success" do
      let(:response) do
        AdvertiserResponse.new(
          {
            errors: nil,
            timestamp: timestamp,
            response: advertiser_hash
          }
        )
      end

      subject{ response }

      its(:error?) { is_expected.to be_falsey }
      specify do
        expect(subject.advertiser).to be_a YahooGeminiClient::Advertiser
      end
    end
  end
end
