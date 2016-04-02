require 'rails_helper'

RSpec.describe 'API Display A List Of Clients', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  before do
    @client = create(:client)
  end

  context 'GET /api/v1/clients' do
    it 'displays a list of all clients' do
      get api_v1_clients_path, {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json.length).to eq(1)

      expect(json[0][:client_type]).to eq(@client.client_type)
      expect(json[0][:gln]).to eq(@client.gln)
      expect(json[0][:full_name]).to eq(@client.full_name)
      expect(json[0][:short_name]).to eq(@client.short_name)
    end
  end
end
