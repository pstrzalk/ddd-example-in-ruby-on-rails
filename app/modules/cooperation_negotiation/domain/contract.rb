module CooperationNegotiation
  module Domain
    class Contract
      include Commons::Domain::WithEvents

      AlreadySignedError = Class.new(StandardError)
      ClientSignatureAlreadyAddedError = Class.new(StandardError)
      CompanySignatureAlreadyAddedError = Class.new(StandardError)

      attr_reader :id, :client_id

      def self.prepare_draft(client_id:)
        contract = new(client_id: client_id)

        event = Events::ContractDraftPrepared.new
        event.client_id = client_id
        event.time = Time.current
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

      def sign_by_company
        raise AlreadySignedByClientError if company_signature

        self.company_signature = true

        dispatch_signature_event
      end

      def modify_text(new_text)
        raise AlreadySignedError if signed?

        self.text = new_text
        self.client_signature = false
        self.company_signature = false

        event = Events::ContractTextModified.new
        event.text = new_text
        event.time = Time.current
        dispatch_event(event)
      end

      private

      def signed?
        client_signature && company_signature
      end

      def dispatch_signature_event
        return unless company_signature && client_signature

        event = Events::ContractSigned.new
        event.client_id = client_id
        event.time = Time.current
        dispatch_event(event)
      end

      attr_writer :id, :client_id
      attr_accessor :client_signature, :company_signature, :text
    end
  end
end
