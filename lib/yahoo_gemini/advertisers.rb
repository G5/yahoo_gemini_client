module YahooGemini
  class Advertisers < Collection

    def all
      response = get(base_uri)
      response.map do |advertiser_hash|
        Advertiser.new(advertiser_hash)
      end
    end

    def find(ids)
      uri = GenerateMemberURI.execute(base_uri, ids)
      response = get(uri.to_s)
      response.map { |advertiser_hash| Advertiser.new(advertiser_hash) }
    end

    def base_uri
      'https://api.admanager.yahoo.com/v1/rest/advertiser/'
    end

  end
end
