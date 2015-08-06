module YahooGeminiClient
  class CustomReport
    def initialize(opts={})
      @client = opts[:client]
    end

    def create(request_body)
      CustomReportJobRequest.new(request_body: request_body, client: @client).
        execute
    end

    def find(params)
      CustomReportCheckJobRequest.new(params.merge(client: @client)).execute
    end
  end
end
