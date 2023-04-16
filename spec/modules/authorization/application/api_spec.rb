require_relative "../../../rails_helper"

module Authorization
  module Application
    describe Api do
      describe '.identity_in_role?' do
        context 'when checking an admin identity' do
          let(:identity) { '00000000-0000-0000-0000-000000000001' }

          it { expect(described_class.identity_in_role?(identity, 'admin')).to be true }
          it { expect(described_class.identity_in_role?(identity, 'client')).to be true }
          it { expect(described_class.identity_in_role?(identity, 'foo')).to be false }
        end

        context 'when checking a client identity' do
          let(:identity) { '00000000-0000-0000-0000-000000000005' }

          it { expect(described_class.identity_in_role?(identity, 'client')).to be true }
          it { expect(described_class.identity_in_role?(identity, 'admin')).to be false }
          it { expect(described_class.identity_in_role?(identity, 'foo')).to be false }
        end

        context 'when checking a non-uuid identity' do
          let(:identity) { 'foo' }

          it { expect(described_class.identity_in_role?(identity, 'client')).to be false }
          it { expect(described_class.identity_in_role?(identity, 'admin')).to be false }
          it { expect(described_class.identity_in_role?(identity, 'bar')).to be false }
        end
      end
    end
  end
end
