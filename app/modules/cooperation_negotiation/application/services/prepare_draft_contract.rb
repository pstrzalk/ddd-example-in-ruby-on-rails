module CooperationNegotiation
  module Application
    module Services
      class PrepareDraftContract
        Unauthorized = Class.new(StandardError)

        def initialize
          self.repository = Domain::ContractRepository.get
        end

        def call(identity:, client_id:)
          # move this authorization API call into domain somehow. It should be domain's decission to allow only admins
          # example in IDDD - collaboratorService is
          # import com.saasovation.collaboration.domain.model.collaborator.CollaboratorService;
          raise Unauthorized unless Authorization::Application::Api.identity_in_role?(identity, 'admin')

          contract = Domain::Contract.prepare_draft(client_id:)

          repository.save(contract)
        end

        private

        attr_accessor :repository
      end
    end
  end
end
