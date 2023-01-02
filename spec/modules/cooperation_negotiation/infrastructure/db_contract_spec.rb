require_relative "../../../rails_helper"

module CooperationNegotiation
  module Infrastructure
    describe DbContract do
      it "can be persisted" do
        expect { described_class.create }.to change(described_class, :count).by(1)
      end
    end
  end
end
