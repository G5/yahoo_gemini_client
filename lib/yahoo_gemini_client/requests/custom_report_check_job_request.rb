module YahooGeminiClient
  class CustomReportCheckJobRequest < CustomReportBaseRequest
    REQUEST_URI = "https://api.admanager.yahoo.com/v1/rest/reports/custom/"

    attribute :advertiser_id, String
    attribute :job_id, String

    def execute
      response = get(request_uri: build_request_uri)
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
