require "oauth2"

module YahooGemini
  class Client
    attr_accessor(
      :consumer_key,
      :consumer_secret,
      :oauth2_client,
      :token,
    )

    def initialize(options={})
      options.each do |key, value|
        instance_variable_set("@#{key}", value)
      end
      @oauth2_client ||= OAuth2::Client.new(consumer_key, consumer_secret, {
        :site => 'https://api.login.yahoo.com',
        :authorize_url => '/oauth2/request_auth',
        :token_url => '/oauth2/get_token',
      })
    end

    def authorization_url
      oauth2_client.auth_code.authorize_url(
        :redirect_uri => "oob",
        :response_type => "code",
        :language => "en-us",
      )
    end

    def encoded_creds
      Base64.encode64("#{consumer_key}:#{consumer_secret}").gsub(/\n/,"").strip
    end

    def get_token(authorization_code)
      self.token = oauth2_client.auth_code.get_token(authorization_code, {
        :redirect_uri => 'oob',
        :headers => oauth2_headers,
      })
    end

    def oauth2_headers
      {
        'Authorization' => "Basic #{encoded_creds}",
        'Content-Type' => 'application/x-www-form-urlencoded',
        'User-Agent' => user_agent,
      }
    end

    def api_request_headers
      {
        "Authorization" => "Bearer #{token.token}",
        "User-Agent" => user_agent,
      }
    end

    def user_agent
      @user_agent ||= "YahooGeminiRubyGem/#{YahooGemini::VERSION}"
    end

    def advertisers
      Advertisers.new(client: self)
    end

    # TODO testme
    def token_refresh!
      self.token = self.token.refresh!({:redirect_uri => 'oob', :headers => oauth2_headers})
    end

  end
end
