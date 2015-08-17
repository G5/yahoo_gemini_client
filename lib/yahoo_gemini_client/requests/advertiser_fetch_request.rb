module YahooGeminiClient
  class AdvertiserFetchRequest < AdvertiserBaseRequest

    attribute :advertiser_id, String

    def execute
      response = get(request_uri: build_request_uri)
      AdvertiserResponse.new(response.with_indifferent_access)
    end

    private

    def build_request_uri
      REQUEST_URI + advertiser_id_http_parameter
    end

    def advertiser_id_http_parameter
      "/#{advertiser_id}"
    end
  end
end
