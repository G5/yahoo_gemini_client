module YahooGeminiClient
  class Advertisers
    def initialize(opts={})
      @client = opts[:client]
    end

    def find(advertiser_id)
      params = { advertiser_id: advertiser_id }
      AdvertiserFetchRequest.new(params.merge(client: @client)).execute
    end
  end
end
