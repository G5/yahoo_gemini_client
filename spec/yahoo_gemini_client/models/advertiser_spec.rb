require 'spec_helper'

module YahooGeminiClient
  describe Advertiser do
    describe "initialization" do
      subject do
        described_class.new(
          "id"=>1111111,
          "advertiserName"=>"Fiat of Dallas",
          "billingCountry"=>"US",
          "bookingCountry"=>"US",
          "currency"=>"USD",
          "language"=>"en",
          "managedBy"=>2222222,
          "status"=>"ACTIVE",
          "timezone"=>"America/Chicago",
          "type"=>"ADVERTISER",
        )
      end

      its(:id) { is_expected.to eq 1111111 }
      its(:advertiser_name) { is_expected.to eq "Fiat of Dallas" }
      its(:billing_country) { is_expected.to eq "US" }
      its(:booking_country) { is_expected.to eq "US" }
      its(:currency) { is_expected.to eq "USD" }
      its(:language) { is_expected.to eq "en" }
      its(:managed_by) { is_expected.to eq 2222222 }
      its(:status) { is_expected.to eq "ACTIVE" }
      its(:timezone) { is_expected.to eq "America/Chicago" }
      its(:type) { is_expected.to eq "ADVERTISER" }
    end
  end
end
