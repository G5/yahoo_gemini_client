module YahooGeminiClient
  class Campaigns < Collection

    def all
      response = get(base_uri)
      response.map do |campaign_hash|
        Campaign.new(campaign_hash)
      end
    end

    def create(opts={})
      params = Campaign.new(opts).to_params_hash
      result = post(base_uri, opts)
      Campaign.new(result)
    end

    # TODO testme
    def where(opts={})
      ids = opts[:id]
      uri = if Array(ids).count > 1
              GenerateMemberURI.execute(base_uri, ids)
            else
              base_uri + ids
            end

      response = get(uri.to_s)
      response.map { |advertiser_hash| Campaign.new(advertiser_hash) }
    end

    def base_uri
      'https://api.admanager.yahoo.com/v1/rest/campaign/'
    end

  end
end
