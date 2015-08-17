module YahooGeminiClient
  class AdvertiserResponse < BaseResponse
    attr_accessor :errors, :timestamp, :advertiser

    def initialize(json_response)
      @errors = json_response[:errors]
      @timestamp = json_response[:timestamp]
      @advertiser = Advertiser.new(json_response[:response])
    end
  end
end
