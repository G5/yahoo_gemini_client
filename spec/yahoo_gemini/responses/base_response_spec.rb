require 'spec_helper'

module YahooGemini
  describe BaseResponse do
    describe "attributes" do
      subject { described_class }

      it { is_expected.to have_attribute(:json_response) }
    end
  end
end
