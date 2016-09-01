require 'spec_helper'

module YahooGeminiClient
  describe CustomReportJobRequest do
    let(:client) do
      Client.new(
        consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
        consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
        refresh_token: ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"],
      )
    end

    describe "#execute" do
      context "success", :vcr =>  { :record => :once } do
        let(:request_body) {
          { cube: "performance_stats",
            fields: [
              { field: "Ad ID" },
              { field: "Day" },
              { alias: "My dummy column", value: "" },
              { field: "Impressions" },
              { field: "Ad Image URL", alias: "url" }
            ],
            filters: [
              { field: "Advertiser ID", operator: "=", value: 1643871 },
              { field: "Campaign ID", operator: "IN", values: [10,20,30] },
              { field: "Day", operator: "between", from: "2015-09-01", to: "2015-09-30" }
            ]
          }
        }

        subject do
          CustomReportJobRequest.new(
            request_body: request_body,
            client: client,
          )
        end

        it "returns a CustomReportResponse object" do
          response = subject.execute
          expect(response).to be_a CustomReportResponse
          expect(response.completed?).to be_falsey
          expect(response.error?).to be_falsey
          expect(response.job_id).to_not eq nil
        end
      end

      context "error", :vcr =>  { :record => :once } do
        let(:request_body) {
          { cube: "performance_stats",
            fields: [
              { field: "Ad ID" },
              { field: "Day" },
              { alias: "My dummy column", value: "" },
              { field: "Impressions" },
              { field: "Ad Image URL", alias: "url" }
            ],
            filters: [
              { field: "Advertiser ID", operator: "=", value: "INVALID VALUE" },
              { field: "Campaign ID", operator: "IN", values: [10,20,30] },
              { field: "Day", operator: "between", from: "2015-07-01", to: "2015-07-30" }
            ]
          }
        }

        subject do
          CustomReportJobRequest.new(
            request_body: request_body,
            client: client,
          )
        end

        it "returns a CustomReportResponse object" do
          response = subject.execute
          expect(response).to be_a CustomReportResponse
          expect(response.completed?).to be_falsey
          expect(response.error?).to be_truthy
          expect(response.job_id).to eq nil
        end
      end
    end
  end
end
