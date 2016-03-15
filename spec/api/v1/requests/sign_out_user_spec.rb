require 'rails_helper'

RSpec.describe 'API Sign Out User', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  context 'DELETE /api/v1/sign_out' do
    it "will invalidate the user's authentication token to end the user's current session" do
      delete destroy_api_v1_user_session_path, {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(authenticated?(:user)).to be_falsey
    end
  end
end
