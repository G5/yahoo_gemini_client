require 'spec_helper'

module YahooGeminiClient
  describe CustomReport do
    let(:advertiser_id) { 12345 }

    describe "#new" do
      let(:request_body) {
        {cube: "performance_stats",
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
            { field: "Advertiser ID", operator: "=", value: advertiser_id },
            { field: "Day", operator: "between", from: "2015-07-01", to: "2015-07-30" }
          ]}
      }

      let(:request) { instance_double("CustomReportJobRequest") }
      let(:response) { instance_double("CustomReportResponse") }

      it "sends a request to Yahoo to create a report with the given parameters" do
        expect(CustomReportJobRequest).to receive(:new).with(request_body: request_body).and_return(request)
        expect(request).to receive(:execute).and_return(response)
        described_class.create(request_body)
      end
    end

    describe "#check" do
      let(:job_id) { "job_id" }
      let(:params) {
        {
          advertiser_id: advertiser_id,
          job_id: job_id
        }
      }
      let(:request) { instance_double("CustomReportCheckJobRequest") }
      let(:response) { instance_double("CustomReportResponse") }

      it "sends a request to Yahoo to create a report with the given parameters" do
        expect(CustomReportCheckJobRequest).to receive(:new).with(params).and_return(request)
        expect(request).to receive(:execute).and_return(response)
        described_class.find(params)
      end
    end
  end
end
