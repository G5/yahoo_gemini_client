require 'spec_helper'

module YahooGeminiClient
  describe CustomReportCheckJobRequest do
    let(:client) do
      Client.new(
        consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
        consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
        token: {
          refresh_token: ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"],
        }
      )
    end

    describe "#execute" do
      let(:requesting_report_job_request_body) {
        { cube: "performance_stats",
          fields: [
            { field: "Ad ID" },
            { field: "Day" },
            { alias: "My dummy column", value: "" },
            { field: "Impressions" },
            { field: "Ad Image URL", alias: "url" }
          ],
          filters: [
            { field: "Advertiser ID", operator: "=", value: advertiser_id },
            { field: "Campaign ID", operator: "IN", values: [10,20,30] },
            { field: "Day", operator: "between", from: "2015-07-01", to: "2015-07-30" }
          ]
        }
      }
      let(:advertiser_id) { 1086126 }
      let!(:custom_report_job_response_job_id) do
        CustomReport.
          new(client: client).
          create(requesting_report_job_request_body).
          job_id
      end

      context "success", :vcr =>  { :record => :once } do
        subject do
          CustomReportCheckJobRequest.new({
            advertiser_id: advertiser_id,
            job_id: custom_report_job_response_job_id,
            client: client,
          })
        end

        it "returns a CustomReportCheckJobRequest object" do
          response = subject.execute
          expect(response).to be_a CustomReportResponse
          expect(response.completed?).to eq true
          expect(response.error?).to eq false
          expect(response.job_id).to eq custom_report_job_response_job_id
          expect(response.csv_url).to match ".csv"
        end
      end

      context "failure", :vcr => { :record => :once } do
        subject do
          CustomReportCheckJobRequest.new({
            advertiser_id: "wrong_advertiser_id",
            job_id: custom_report_job_response_job_id,
            client: client,
          })
        end

        it "returns a CustomReportCheckJobRequest object with an error" do
          response = subject.execute
          expect(response).to be_a CustomReportResponse
          expect(response.completed?).to eq false
          expect(response.error?).to eq true
          expect(response.job_id).to eq nil
          expect(response.csv_url).to eq nil
        end
      end
    end
  end
end
