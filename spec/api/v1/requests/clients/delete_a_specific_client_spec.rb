require 'rails_helper'

RSpec.describe 'API Delete Client', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  before do
    @client = create(:client)
  end

  context 'DELETE /api/v1/clients/:id' do
    it 'deletes a specific client' do
      delete api_v1_client_path(id: @client.id), {}, headers

      expect(response).to have_http_status(204)
    end
  end
end
