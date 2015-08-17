require "active_model"
require "httparty"
require "virtus"
require "active_support/core_ext/hash/indifferent_access"
require "yahoo_gemini_client/version"
require "yahoo_gemini_client/client"
require "yahoo_gemini_client/generate_member_uri"
require "yahoo_gemini_client/models/campaign"
require "yahoo_gemini_client/models/advertiser"
require "yahoo_gemini_client/services/campaigns"
require "yahoo_gemini_client/services/custom_report"
require "yahoo_gemini_client/services/advertisers"
require "yahoo_gemini_client/responses/base_response"
require "yahoo_gemini_client/responses/advertiser_response"
require "yahoo_gemini_client/requests/base_request"
require "yahoo_gemini_client/requests/custom_report_base_request"
require "yahoo_gemini_client/requests/custom_report_job_request"
require "yahoo_gemini_client/requests/custom_report_check_job_request"
require "yahoo_gemini_client/requests/campaign_base_request"
require "yahoo_gemini_client/requests/campaign_fetch_request"
require "yahoo_gemini_client/requests/advertiser_base_request"
require "yahoo_gemini_client/requests/advertiser_fetch_request"
require "yahoo_gemini_client/responses/custom_report_response"
require "yahoo_gemini_client/responses/campaign_response"

module YahooGeminiClient

  def self.new(*args)
    Client.new(*args)
  end

end
