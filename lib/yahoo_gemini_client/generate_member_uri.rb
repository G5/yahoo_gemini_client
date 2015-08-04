module YahooGeminiClient
  class GenerateMemberURI

    def self.execute(base_uri, ids)
      uri = URI.parse(base_uri)
      ids = [ids].flatten
      uri.query = ids.map { |id| "id=#{id}" }.join("&")
      uri.to_s
    end

  end
end
