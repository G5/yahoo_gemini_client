module YahooGeminiClient
  class CustomReportCheckJobRequest < BaseRequest
    REQUEST_URI = "https://api.admanager.yahoo.com/v1/rest/reports/custom/"

    attribute :request_body, String
    attribute :advertiser_id, String
    attribute :job_id, String

    def execute
      http_authorization_header = {"Authorization" => "Bearer #{access_token}"}
      response = HTTParty.get(build_request_uri,
        headers: http_request_header.merge(http_authorization_header),
      )
      CustomReportResponse.new(response.with_indifferent_access)
    end

    private

    def build_request_uri
      REQUEST_URI + job_id + advertiser_id_http_parameter
    end

    def advertiser_id_http_parameter
      "?advertiserId=#{advertiser_id}"
    end
  end
end
