module YahooGeminiClient
  class CustomReport
    def self.create(request_body)
      CustomReportJobRequest.new(request_body: request_body).execute
    end

    def self.find(params)
      CustomReportCheckJobRequest.new(params).execute
    end
  end
end
