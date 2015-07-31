module YahooGemini
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

  end
end
