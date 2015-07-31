require 'spec_helper'

module YahooGemini
  RSpec.describe GenerateMemberURI, ".execute" do
    let(:base_uri) { "http://base.com" }

    it "sets the query to be the given IDs" do
      expect(described_class.execute(base_uri, [4, 5])).
        to eq "http://base.com?id=4&id=5"
      expect(described_class.execute(base_uri, 5)).
        to eq "http://base.com?id=5"
    end
  end
end
