module YahooGeminiClient
  class Campaigns
    def initialize(opts={})
      @client = opts[:client]
    end

    def where(params)
      CampaignFetchRequest.new(params.merge(client: @client)).execute
    end
  end
end
