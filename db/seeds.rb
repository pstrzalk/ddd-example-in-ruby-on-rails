contract_repository = CooperationNegotiation::Infrastructure::DbContractRepository.new

# Yes, I know those are not valid UUIDs!

client_id = '00000000-0000-0000-0000-000000000001'
CooperationNegotiation::Application::PrepareDraftContractService.new.call(client_id: client_id)
contract = contract_repository.of_client_id(client_id)
CooperationNegotiation::Application::ModifyContractTextService.new.call(contract_id: contract.id, text: 'foo foo')

client_id = '00000000-0000-0000-0000-000000000002'
CooperationNegotiation::Application::PrepareDraftContractService.new.call(client_id: client_id)
contract = contract_repository.of_client_id(client_id)
CooperationNegotiation::Application::SignContractByClientService.new.call(contract_id: contract.id)

client_id = '00000000-0000-0000-0000-000000000003'
CooperationNegotiation::Application::PrepareDraftContractService.new.call(client_id: client_id)
contract = contract_repository.of_client_id(client_id)
CooperationNegotiation::Application::SignContractByClientService.new.call(contract_id: contract.id)
CooperationNegotiation::Application::SignContractByCompanyService.new.call(contract_id: contract.id)

puts 'All Contracts'
pp CooperationNegotiation::Infrastructure::DbContract.all

puts 'All Parties'
pp DragonHunt::Infrastructure::DbParty.all
