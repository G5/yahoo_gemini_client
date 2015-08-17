module YahooGeminiClient
  class AdGroups
    def initialize(opts={})
      @client = opts[:client]
    end

    def find(ad_group_id)
      params = { ad_group_id: ad_group_id }
      AdGroupFetchRequest.new(params.merge(client: @client)).execute
    end
  end
end
