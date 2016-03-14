require 'rails_helper'

RSpec.describe 'API Account Deletion', type: :request do
  let!(:user) { create(:user) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  context 'DELETE /api/v1/auth' do
    it 'destroys users identified by their uid and auth_token headers' do
      delete api_v1_user_registration_path, {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')
    end
  end
end
