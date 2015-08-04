module YahooGeminiClient
  class Advertiser

    def initialize(hash)
      @hash = hash
    end

    def id
      @hash["id"]
    end

    def advertiser_name
      @hash["advertiserName"]
    end

    def billing_country
      @hash["billingCountry"]
    end

    def booking_country
      @hash["bookingCountry"]
    end

    def currency
      @hash["currency"]
    end

    def language
      @hash["language"]
    end

    def managed_by
      @hash["managedBy"]
    end

    def status
      @hash["status"]
    end

    def timezone
      @hash["timezone"]
    end

    def type
      @hash["type"]
    end

  end
end
