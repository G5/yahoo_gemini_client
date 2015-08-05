module YahooGeminiClient
  class Campaign

    def initialize(campaign_hash)
      @hash = campaign_hash
    end

    def id
      @hash["id"]
    end

    def status
      @hash["status"]
    end

    def campaign_name
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

  end
end
