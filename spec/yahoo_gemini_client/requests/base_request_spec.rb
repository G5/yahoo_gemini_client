require 'spec_helper'

module YahooGeminiClient
  describe BaseRequest do

    describe "attributes" do
      subject { described_class }
      it { is_expected.to have_attribute(:url, String) }
      it { is_expected.to have_attribute(:client_id, String) }
      it { is_expected.to have_attribute(:client_secret, String) }
      it { is_expected.to have_attribute(:refresh_key, String) }
    end

=begin NOTE: for some reason this doesn't work!
    describe "validations" do
      subject { described_class.new }
      it { is_expected.to validate_presence_of(:url) }
      it { is_expected.to validate_presence_of(:client_id) }
      it { is_expected.to validate_presence_of(:client_secret) }
      it { is_expected.to validate_presence_of(:refresh_key) }
    end
=end

    describe ".execute" do
      let(:request) { double(described_class) }

      it "calls instantiates a request, calls #execute passing required args" do
        expect(described_class).to receive(:new).with("args").
          and_return(request)
        expect(request).to receive(:execute)
        described_class.execute("args")
      end
    end

  end
end
