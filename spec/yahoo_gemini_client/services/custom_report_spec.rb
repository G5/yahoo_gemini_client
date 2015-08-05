require 'spec_helper'

module YahooGeminiClient
  describe CustomReport do
    subject { described_class.create(
      cube: "performance_stats",
      fields: [
        { field: "Day" },
        { field: "Advertiser ID" },
        { field: "Advertiser Name" },
        { field: "Campaign ID" },
        { field: "Campaign Name" },
        { field: "Impressions" },
        { field: "Clicks" },
        { field: "CTR" },
        { field: "Spend" },
        { field: "Average Position" },
        { field: "Average CPC" },
        { field: "Keyword ID" },
        { field: "Keyword Value" },
      ],
      filters: [
        { field: "Advertiser ID", operator: "=", value: 12345 },
        { field: "Day", operator: "between", from: start_date, to: end_date }
      ]
    ) }
  end
end
