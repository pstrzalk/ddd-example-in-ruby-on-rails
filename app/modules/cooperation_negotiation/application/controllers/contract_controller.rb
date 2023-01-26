module CooperationNegotiation
  module Application
    module Controllers
      class ContractController < ::ApplicationController
        def prepare_draft
          service = Services::PrepareDraftContract.new
          service.call(current_identity, params[:client_id])

          render :ok
        end
      end
    end
  end
end
