class ReadModelHandler
  DEFINITIONS = {
    'CooperationNegotiation::Domain::Events::ContractSigned' => [
      {
        model: ReadModels::SignedContract,
        identity_attribute: 'contract_id',
        event_read_model_attribute_map: {
          client_id: 'client_id',
          text: 'text',
          time: 'created_at'
        }
      }
    ]
  }.freeze

  def self.call(event)
    definitions = DEFINITIONS[event.class.name]
    return unless definitions

    definitions.each do |definition|
      read_model_attributes = definition[:event_read_model_attribute_map].to_h do |event_key, read_model_key|
        [read_model_key, event.public_send(event_key)]
      end

      definition[:model].save_record(
        event.public_send(definition[:identity_attribute]),
        read_model_attributes
      )
    end
  end
end
