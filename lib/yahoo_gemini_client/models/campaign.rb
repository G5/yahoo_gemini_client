module YahooGeminiClient
  class Campaign

    def initialize(campaign_hash)
      @hash = campaign_hash.map do |key,value|
        {key.to_s.camelize(:lower) => value}
      end.reduce(:merge)
    end

    def id
      @hash["id"]
    end

    def status
      @hash["status"]
    end

    def name
      @hash["campaignName"]
    end

    def budget
      @hash["budget"]
    end

    def language
      @hash["language"]
    end

    def budget_type
      @hash["budgetType"]
    end

    def advertiser_id
      @hash["advertiserId"]
    end

    def channel
      @hash["channel"]
    end

    def objective
      @hash["objective"]
    end

    def is_partner_network
      @hash["isPartnerNetwork"]
    end

    def default_landing_url
      @hash["defaultLandingUrl"]
    end

    def tracking_partner
      @hash["trackingPartner"]
    end

    def app_locale
      @hash["appLocale"]
    end

    def to_params_hash
      @hash
    end

  end
end
