module YahooGeminiClient
  class CampaignResponse
    attr_accessor :errors, :timestamp, :campaigns

    def initialize(json_response)
      @errors = json_response[:errors]
      @timestamp = json_response[:timestamp]
      if json_response[:response]
        build_campaigns(json_response[:response])
      end
    end

    def error?
      !@errors.nil?
    end

    private

    def build_campaigns(campaigns_hashes)
      @campaigns = campaigns_hashes.map do |campaign_hash|
        Campaign.new(campaign_hash)
      end
    end
  end
end
