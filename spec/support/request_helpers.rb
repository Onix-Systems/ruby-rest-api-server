module Requests
  module JsonHelpers
    def json
      JSON.parse(response.body, symbolize_names: true)
    end
  end

  module DeviseRequestSpecHelpers
    include Warden::Test::Helpers

    def sign_in(resource_or_scope, resource = nil)
      resource ||= resource_or_scope
      scope = Devise::Mapping.find_scope!(resource_or_scope)
      login_as(resource, scope: scope)
    end

    def sign_out(resource_or_scope)
      scope = Devise::Mapping.find_scope!(resource_or_scope)
      logout(scope)
    end

    def authenticated?(scope)
      warden = request.env['warden']
      warden.authenticated?(scope)
    end
  end
end
