module Authorization
  module Application
    class Api
      def self.identity_in_role?(identity, role_name)
        return true if identity == '00000000-0000-0000-0000-000000000001' && role_name == 'admin'
        return true if identity == '00000000-0000-0000-0000-000000000005' && role_name == 'client'

        false
      end
    end
  end
end
