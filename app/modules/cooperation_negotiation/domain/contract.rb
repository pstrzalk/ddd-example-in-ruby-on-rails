module CooperationNegotiation
  module Domain
    class Contract
      include Commons::Domain::WithEvents

      AlreadySignedError = Class.new(StandardError)
      AlreadySignedByClientError = Class.new(StandardError)
      AlreadySignedByCompanyError = Class.new(StandardError)

      attr_reader :id, :client_id, :text

      def self.prepare_draft(client_id:)
        contract = new(client_id: client_id)

        event = Events::ContractDraftPrepared.new
        event.client_id = client_id
        event.time = ::Clock.utc
        contract.send(:dispatch_event, event)

        contract
      end

      def initialize(client_id:, id: nil)
        self.id = id
        self.client_id = client_id
        self.text = ''
        self.client_signature = false
        self.company_signature = false
      end

      def sign_by_client
        raise AlreadySignedByClientError if client_signature

        self.client_signature = true

        dispatch_signature_event
      end

      def signed_by_client?
        self.client_signature
      end

      def sign_by_company
        raise AlreadySignedByCompanyError if company_signature

        self.company_signature = true

        dispatch_signature_event
      end

      def signed_by_company?
        self.company_signature
      end

      def modify_text(new_text)
        raise AlreadySignedError if signed?

        self.text = new_text
        self.client_signature = false
        self.company_signature = false

        event = Events::ContractTextModified.new
        event.text = new_text
        event.time = ::Clock.utc
        dispatch_event(event)
      end

      private

      def signed?
        signed_by_client? && signed_by_company?
      end

      def dispatch_signature_event
        return unless signed?

        event = Events::ContractSigned.new
        event.client_id = client_id
        event.text = text
        event.time = ::Clock.utc
        dispatch_event(event)
      end

      attr_writer :id, :client_id, :text
      attr_accessor :client_signature, :company_signature
    end
  end
end
