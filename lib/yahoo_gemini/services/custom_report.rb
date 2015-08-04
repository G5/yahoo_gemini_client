module YahooGemini
  class CustomReport

    include Virtus.model

    attribute :request_body

    def self.create(request_body)
      self.new(request_body: request_body)
    end
  end
end
