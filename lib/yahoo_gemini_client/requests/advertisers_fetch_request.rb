module YahooGeminiClient
  class AdvertisersFetchRequest < AdvertiserBaseRequest

    def execute
      response = get(request_uri: build_request_uri)
      AdvertisersResponse.new(response.with_indifferent_access)
    end

    private

    def build_request_uri
      REQUEST_URI
    end

  end
end
