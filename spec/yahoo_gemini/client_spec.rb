require 'spec_helper'

module YahooGemini
  describe Client do
    let(:client) do
      described_class.new(
        consumer_key: "consumer_key",
        consumer_secret: "consumer_secret"
      )
    end

    it "initializes with consumer credentials" do
      expect(client.consumer_key).to eq("consumer_key")
      expect(client.consumer_secret).to eq("consumer_secret")
    end

    describe '#user_agent' do
      it "defaults YahooGeminiRubyGem/version" do
        expect(subject.user_agent).to eq("YahooGeminiRubyGem/#{YahooGemini::VERSION}")
      end
    end

    describe "#authorization_url" do
      subject(:authorization_url) do
        described_class.new(
          consumer_key: "consumer_key",
          consumer_secret: "consumer_secret",
        ).authorization_url
      end

      it "returns Authorization URL to authorize API access" do
        require 'uri'
        parsed_url = ::URI.parse(authorization_url)
        expect(authorization_url).to match("https://api.login.yahoo.com/oauth2/request_auth")
        expect(parsed_url.host).to eq("api.login.yahoo.com")
        expect(parsed_url.path).to eq("/oauth2/request_auth")
        expect(parsed_url.query).to eq("client_id=consumer_key&language=en-us&redirect_uri=oob&response_type=code")
      end
    end

    describe "#get_token", :vcr =>  { :record => :once } do
      let(:client) do
        described_class.new(
          consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
          consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
        )
      end
      let(:authorization_code) { ENV["YAHOO_GEMINI_TEST_AUTHORIZATION_CODE"] }

      it "uses the Authorization Code to get an Access Token" do
        client.get_token(authorization_code)
        expect(client.access_token).to be_a(OAuth2::AccessToken)
        expect(client.access_token.expired?).to eq false
      end
    end

  end
end

