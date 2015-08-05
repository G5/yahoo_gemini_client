module YahooGeminiClient
  class Campaigns < Collection

    def all
      response = get(base_uri)
      response.map do |campaign_hash|
        Campaign.new(campaign_hash)
      end
    end

    def create(opts={})
      result = post(base_uri, opts)
      Campaign.new(result)
    end

    def base_uri
      'https://api.admanager.yahoo.com/v1/rest/campaign/'
    end
  end
end
