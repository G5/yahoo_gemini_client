require 'spec_helper'

module YahooGeminiClient
  describe AdGroup do
    describe "initialization" do
      subject do
        described_class.new(
          "status"=>"PAUSED",
          "id"=>1111111111,
          "bidSet"=>{
            "bids"=>[
              {"priceType"=>"CPC", "value"=>22.83, "channel"=>"NATIVE"},
              {"priceType"=>"CPC", "value"=>22.83, "channel"=>"SEARCH"}
            ]
          },
          "advertiserId"=>2222222,
          "adGroupName"=>"Test Ad Group",
          "campaignId"=>333333333,
          "startDateStr"=>"2015-08-06",
          "endDateStr"=>"2015-09-06"
        )
      end

      its(:id) { is_expected.to eq 1111111111 }
      its(:advertiser_id) { is_expected.to eq 2222222 }
      # TODO wrap into array of Bid objects instead
      its(:bid_set) do
        is_expected.to eq(
          "bids"=>[
            {"priceType"=>"CPC", "value"=>22.83, "channel"=>"NATIVE"},
            {"priceType"=>"CPC", "value"=>22.83, "channel"=>"SEARCH"}
          ]
        )
      end
      its(:ad_group_name) { is_expected.to eq "Test Ad Group" }
      its(:campaign_id) { is_expected.to eq 333333333 }
      its(:start_date_str) { is_expected.to eq "2015-08-06" }
      its(:end_date_str) { is_expected.to eq "2015-09-06" }

    end
  end
end
