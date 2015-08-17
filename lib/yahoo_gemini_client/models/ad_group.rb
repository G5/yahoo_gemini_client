module YahooGeminiClient
  class AdGroup

    def initialize(hash)
      @hash = hash
    end

    def id
      @hash["id"]
    end

    def bid_set
      # TODO wrap into array of Bid objects
      @hash["bidSet"]
    end

    def advertiser_id
      @hash["advertiserId"]
    end

    def ad_group_name
      @hash["adGroupName"]
    end

    def campaign_id
      @hash["campaignId"]
    end

    def start_date_str
      @hash["startDateStr"]
    end
    def end_date_str
      @hash["endDateStr"]
    end

  end
end

