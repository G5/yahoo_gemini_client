module YahooGemini
  class Advertisers < Collection

    def all
      response = HTTParty.get(
        'https://api.admanager.yahoo.com/v1/rest/advertiser/',
        headers: api_request_headers,
      )

      if response.success?
        parsed = JSON.parse(response.body)
        parsed["response"].map do |advertiser_hash|
          Advertiser.new(advertiser_hash)
        end
      else
        raise "Reponse Unsuccessful: #{response.body}"
      end
    end

    def find(ids)
      uri = URI.parse('https://api.admanager.yahoo.com/v1/rest/advertiser/')
      uri.query = ids.map { |id| "id=#{id}" }.join("&")
      response = HTTParty.get(uri.to_s, headers: api_request_headers)
      parsed = JSON.parse(response.body)
      parsed["response"].map do |advertiser_hash|
        Advertiser.new(advertiser_hash)
      end
    end

  end
end
