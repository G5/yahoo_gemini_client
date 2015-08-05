require 'spec_helper'

module YahooGeminiClient
  describe CustomReportJobResponse do
    let(:response) do
      CustomReportJobResponse.new(
        {
          errors: nil,
          timestamp: "2015-08-05 4:16:19",
          response: {jobId: "78e9de9db5ee0fbc86225e3387ee22155913ad7c49278523", status:"submitted", jobResponse: nil}
        }
      )
    end

    subject{ response }

    its(:error?) { is_expected.to be_falsey}
    its(:completed?) { is_expected.to be_falsey}
    its(:job_id) { is_expected.to eq "78e9de9db5ee0fbc86225e3387ee22155913ad7c49278523"}
  end
end
