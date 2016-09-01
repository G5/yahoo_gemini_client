module YahooGeminiClient
  class CustomReportBaseRequest < BaseRequest
    REQUEST_URI = "https://api.admanager.yahoo.com/v2/rest/reports/custom"
    include Virtus.model

    def http_authorization_header
      {"Authorization" => "Bearer #{access_token}"}
    end

    protected

    def post(opts)
      HTTParty.post(REQUEST_URI,
        headers: http_request_header.merge(http_authorization_header),
        body: request_body.to_json,
      )
    end

    def get(opts)
      HTTParty.get(opts[:request_uri],
        headers: http_request_header.merge(http_authorization_header),
      )
    end
  end
end
