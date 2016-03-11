require 'rails_helper'

RSpec.describe 'API Account Deletion', type: :request do
  include_context 'Provide Warden test helpers'
  include_context 'Reset Warden in test mode in the cleanup phase'

  describe 'DELETE /auth' do
    it 'destroys users identified by their uid and auth_token headers' do
      user = create(:user)
      sign_in user
      headers = { 'ACCEPT' => 'application/json' }
      auth_headers = user.create_new_auth_token

      delete api_v1_user_registration_path, {}, headers.merge!(auth_headers)

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')
    end
  end
end
