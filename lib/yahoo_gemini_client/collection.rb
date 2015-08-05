module YahooGeminiClient
  class Collection

    attr_reader :client
    include Enumerable

    def initialize(opts={})
      @client = opts[:client]
    end

    def api_request_headers
      client.api_request_headers
    end

    def each
      @members ||= all
      @members.each { |member| yield member }
    end

    private

    def get(uri)
      response = HTTParty.get(uri, headers: api_request_headers)
      if response.success?
        JSON.parse(response.body).with_indifferent_access[:response]
      else
        # TODO testme
        raise "GET Request Unsuccessful. Response: #{response.body}"
      end
    end

    def post(uri, opts={})
      response = HTTParty.post(uri,{
        headers: api_request_headers,
        body: opts.to_json
      })
      if response.success?
        JSON.parse(response.body).with_indifferent_access[:response]
      else
        # TODO testme
        raise "POST Request Unsuccessful. Response: #{response.body}"
      end
    end

    def member_uri(ids)
      GenerateMemberURI.execute(ids)
    end

    def base_uri
      raise 'This must be overriden'
    end

  end
end
