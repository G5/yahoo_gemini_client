module YahooGemini
  class Advertisers < Collection

    BASE_URI = 'https://api.admanager.yahoo.com/v1/rest/advertiser/'

    def all
      response = get(BASE_URI)
      response.map do |advertiser_hash|
        Advertiser.new(advertiser_hash)
      end
    end

    def find(ids)
      uri = URI.parse(BASE_URI)
      uri.query = ids.map { |id| "id=#{id}" }.join("&")

      response = get(uri.to_s)
      response.map do |advertiser_hash|
        Advertiser.new(advertiser_hash)
      end
    end

  end
end
