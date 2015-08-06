module YahooGeminiClient
  class CustomReportJobRequest < BaseRequest
    REQUEST_URI = "https://api.admanager.yahoo.com/v1/rest/reports/custom"

    attribute :request_body

    def execute
      http_authorization_header = {"Authorization" => "Bearer #{access_token}"}
      response = HTTParty.post(REQUEST_URI,
        headers: http_request_header.merge(http_authorization_header),
        body: request_body.to_json,
      )
      CustomReportResponse.new(response.with_indifferent_access)
    end
  end
end
