module YahooGeminiClient
  class AdGroupFetchRequest < AdGroupBaseRequest

    attribute :ad_group_id, String

    def execute
      response = get(request_uri: build_request_uri)
      AdGroupResponse.new(response.with_indifferent_access)
    end

    private

    def build_request_uri
      REQUEST_URI + ad_group_id_http_parameter
    end

    def ad_group_id_http_parameter
      "/#{ad_group_id}"
    end
  end
end
