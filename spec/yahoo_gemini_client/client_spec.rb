require 'spec_helper'

module YahooGeminiClient
  describe Client do
    let(:consumer_key) { ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"] }
    let(:consumer_secret) { ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"] }
    let(:access_token) { ENV["YAHOO_GEMINI_TEST_ACCESS_TOKEN"] }
    let(:refresh_token) { ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"] }
    let(:expires_at) { Time.now + 200 }

    context "initialization" do
      let(:client) do
        described_class.new(
          consumer_key: consumer_key,
          consumer_secret: consumer_secret,
        )
      end

      it "initializes with consumer credentials" do
        expect(consumer_key).not_to be_empty
        expect(consumer_secret).not_to be_empty

        expect(client.consumer_key).to eq(consumer_key)
        expect(client.consumer_secret).to eq(consumer_secret)
      end

      context "with access token and refresh token" do
        let(:client) do
          described_class.new(
            consumer_key: consumer_key,
            consumer_secret: consumer_secret,
            token: {
              access_token: access_token,
              refresh_token: refresh_token,
            },
          )
        end

        it "initializes the oauth2 token" do
          expect(access_token).not_to be_empty
          expect(refresh_token).not_to be_empty

          expect(client.token.token).to eq access_token
          expect(client.token.refresh_token).to eq refresh_token
        end
      end
    end

    describe "#user_agent" do
      it "defaults YahooGeminiClientRubyGem/version" do
        expect(subject.user_agent).to eq("YahooGeminiClientRubyGem/#{YahooGeminiClient::VERSION}")
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
        # TODO: use refresh token so you don't have to authorize manually
        client.get_token(authorization_code)
        expect(client.token).to be_a(OAuth2::AccessToken)
        expect(client.token.expired?).to eq false
      end
    end

    describe "#advertisers", :vcr => { :record => :once } do
      let(:client) do
        client = described_class.new(
          consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
          consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
        )
        client.get_token(authorization_code)
        client
      end
      let(:authorization_code) { ENV["YAHOO_GEMINI_TEST_AUTHORIZATION_CODE"] }

      it "gets a list of advertisers", :vcr => { :record => :new_episodes } do
        expect(client.token.expired?).to eq false
        advertisers = client.advertisers

        expect(advertisers.count).to be > 0
        expect(advertisers.first.id).to be > 0
        expect(advertisers.first.currency).to eq "USD"
      end
    end

    describe "#campaigns", vcr: { record: :once } do
      let(:client) do
        client = described_class.new(
          consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
          consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
          token: {
            refresh_token: ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"]
          }
        )
        client.token_refresh!
        client
      end
      let(:advertisers) { client.advertisers }
      let(:advertiser_id) { advertisers.first.id }

      it "gets a list of campaigns" do
        expect(client.token.expired?).to eq false
        # assume campaigns are already created
        campaigns = client.campaigns

        expect(campaigns.count).to be > 0
        expect(campaigns.first.id).to be > 0
      end
    end

    describe "#token_refresh!", vcr: { :record => :once } do
      let(:reinitialized_client) do
        described_class.new(
          consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
          consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
          token: {
            access_token: ENV["YAHOO_GEMINI_TEST_ACCESS_TOKEN"],
            refresh_token: ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"],
          }
        )
      end

      it "gets a new access token given a valid refresh token" do
        expect(reinitialized_client.token.token).to eq ENV["YAHOO_GEMINI_TEST_ACCESS_TOKEN"]

        reinitialized_client.token_refresh!

        expect(reinitialized_client.token.token).not_to be_empty
        expect(reinitialized_client.token.token).not_to eq ENV["YAHOO_GEMINI_TEST_ACCESS_TOKEN"]
        expect(reinitialized_client.token.refresh_token).to eq ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"]
      end
    end

  end
end

