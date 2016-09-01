require 'spec_helper'

module YahooGeminiClient
  describe Advertisers do
    let(:advertiser_id) { 1643871 }
    let(:client) do
      Client.new(
        consumer_key: ENV["YAHOO_GEMINI_TEST_CONSUMER_KEY"],
        consumer_secret: ENV["YAHOO_GEMINI_TEST_CONSUMER_SECRET"],
        refresh_token: ENV["YAHOO_GEMINI_TEST_REFRESH_TOKEN"],
      )
    end

    describe "#find" do
      let(:id) { advertiser_id }

      let(:request) { instance_double("AdvertiserFetchRequest") }
      let(:response) { instance_double("AdvertiserResponse") }

      it "sends a request to Yahoo to fetch data of an advertiser" do
        params = { advertiser_id: id }
        expect(AdvertiserFetchRequest).
          to receive(:new).
          with(params.merge(client: client)).
          and_return(request)
        expect(request).to receive(:execute).and_return(response)
        described_class.new(client: client).find(id)
      end
    end

    describe "#all" do
      let(:request) { instance_double("AdvertisersFetchRequest") }
      let(:response) { instance_double("AdvertisersResponse") }

      it "sends a request to Yahoo to fetch data of all advertisers" do
        expect(AdvertisersFetchRequest).
          to receive(:new).
          and_return(request)
        expect(request).to receive(:execute).and_return(response)
        described_class.new(client: client).all
      end
    end
  end
end
