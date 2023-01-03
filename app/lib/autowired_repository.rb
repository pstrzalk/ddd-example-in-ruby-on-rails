module AutowiredRepository
  # Solution inspired by Java's Hibernate annotiations, which allow using repositories as domain objects
  # The domain objects are automatically replaced with implementations on usage
  # Example may be found in https://github.com/VaughnVernon/IDDD_Samples - implementation of examples from the Red Book

  # Java Example description
  # Application layer uses repository as a domain object
  # https://github.com/VaughnVernon/IDDD_Samples/blob/master/iddd_identityaccess/src/main/java/com/saasovation/identityaccess/application/AccessApplicationService.java#L25
  # Even though this domain object is just an interface
  # https://github.com/VaughnVernon/IDDD_Samples/blob/master/iddd_identityaccess/src/main/java/com/saasovation/identityaccess/domain/model/identity/GroupRepository.java
  # The repository is automatically wired to inMemory implementation in test env
  # https://github.com/VaughnVernon/IDDD_Samples/blob/master/iddd_identityaccess/src/test/resources/applicationContext-identityaccess-test.xml#L35
  # The repository is automatically wired to Hibernate implementation in other envs
  # https://github.com/VaughnVernon/IDDD_Samples/blob/master/iddd_identityaccess/src/main/resources/applicationContext-identityaccess.xml#L33

  def get
    self.name.gsub('::Domain::', "::Infrastructure::#{wire_type}").constantize.new
  end

  # This way of defining repository implementations doesn't scale well for a bigger application
  # However, this is just an example - this may be done with JSONs, YMLs, meta programing or any other solution
  def wire_type
    return 'Db' unless Rails.env.test?

    if self.name == 'CooperationNegotiation::Domain::ContractRepository'
      'InMemory'
    else
      'Db'
    end
  end
end
