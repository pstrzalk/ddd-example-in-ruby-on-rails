def print_header(label)
  puts "\n========================\n== #{label}"
end

contract_repository = CooperationNegotiation::Infrastructure::DbContractRepository.new

client_id = '00000000-0000-0000-0000-000000000001'
CooperationNegotiation::Application::Services::PrepareDraftContract.new.call(client_id: client_id)
contract = contract_repository.of_client_id(client_id)
CooperationNegotiation::Application::Services::ModifyContractText.new.call(contract_id: contract.id, text: 'foo foo')

client_id = '00000000-0000-0000-0000-000000000002'
CooperationNegotiation::Application::Services::PrepareDraftContract.new.call(client_id: client_id)
contract = contract_repository.of_client_id(client_id)
CooperationNegotiation::Application::Services::SignContractByClient.new.call(contract_id: contract.id)

client_id = '00000000-0000-0000-0000-000000000003'
CooperationNegotiation::Application::Services::PrepareDraftContract.new.call(client_id: client_id)
contract = contract_repository.of_client_id(client_id)
CooperationNegotiation::Application::Services::ModifyContractText.new.call(contract_id: contract.id, text: 'The correct one')
CooperationNegotiation::Application::Services::SignContractByClient.new.call(contract_id: contract.id)
CooperationNegotiation::Application::Services::SignContractByCompany.new.call(contract_id: contract.id)

print_header 'Contracts'
pp CooperationNegotiation::Infrastructure::DbContract.all

print_header 'Parties'
pp DragonHunt::Infrastructure::DbParty.all

print_header 'ReadModels::SignedContracts'
pp ReadModels::SignedContract.all
