module YahooGeminiClient
  class CustomReportResponse
    attr_accessor :errors, :timestamp, :job_id, :status, :csv_url

    def initialize(json_response)
      @errors = json_response[:errors]
      @timestamp = json_response[:timestamp]
      @job_id = json_response[:response][:jobId]
      @status = json_response[:response][:status]
      @csv_url = json_response[:response][:jobResponse]
    end

    def error?
      !@errors.nil?
    end

    def completed?
      @status == "completed"
    end
  end
end
