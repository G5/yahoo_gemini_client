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

  end
end
