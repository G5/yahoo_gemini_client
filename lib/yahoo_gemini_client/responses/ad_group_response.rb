module YahooGeminiClient
  class AdGroupResponse < BaseResponse
    attr_accessor :errors, :timestamp, :ad_group

    def initialize(json_response)
      @errors = json_response[:errors]
      @timestamp = json_response[:timestamp]
      @ad_group = AdGroup.new(json_response[:response])
    end
  end
end
