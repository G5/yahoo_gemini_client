require 'spec_helper'

module YahooGeminiClient
  describe CustomReportResponse do
    let(:csv_url) { "https://nads.zenfs.com/nads/reportGeneration/14388194548561824a6b77245dc0efb49b68ddee56afeb83f8baa.csv" }
    let(:job_id) { "job_id" }
    let(:timestamp) { "2015-08-05 4:16:19" }

    context "submitted" do
      let(:response) do
        CustomReportResponse.new(
          {
            errors: nil,
            timestamp: timestamp,
            response: {jobId: job_id, status:"submitted", jobResponse: nil}
          }
        )
      end

      subject{ response }

      its(:error?) { is_expected.to be_falsey}
      its(:completed?) { is_expected.to be_falsey}
      its(:job_id) { is_expected.to eq job_id}
    end

    context "completed" do
      let(:response) do
        CustomReportResponse.new(
          {
            errors: nil,
            timestamp: timestamp,
            response: {
              jobId: job_id,
              status:"completed",
              jobResponse: csv_url
            }
          }
        )
      end

      subject{ response }

      its(:error?) { is_expected.to be_falsey }
      its(:completed?) { is_expected.to be_truthy }
      its(:job_id) { is_expected.to eq job_id }
      its(:csv_url) { is_expected.to eq csv_url }
    end
  end
end
