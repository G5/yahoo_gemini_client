module YahooGeminiClient
  class CustomReportJobResponse
    attr_accessor :errors, :timestamp, :job_id, :status, :job_response

    def initialize(json_response)
      @errors = json_response[:errors]
      @timestamp = json_response[:timestamp]
      @job_id = json_response[:response][:jobId]
      @status = json_response[:response][:status]
      @job_response = json_response[:response][:jobResponse]
    end

    def error?
      !@errors.nil?
    end

    def completed?
      @status == "completed"
    end

  end
end
