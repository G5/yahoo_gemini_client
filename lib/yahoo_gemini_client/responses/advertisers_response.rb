module YahooGeminiClient
  class AdvertisersResponse < BaseResponse
    attr_accessor :errors, :timestamp, :advertisers

    def initialize(json_response)
      @errors = json_response[:errors]
      @timestamp = json_response[:timestamp]
      @advertisers = json_response[:response].map do |advertiser_hash|
        Advertiser.new(advertiser_hash)
      end
    end
  end
end
