require 'rails_helper'

RSpec.describe 'API Create Client', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  context 'POST /api/v1/clients' do
    it 'creates new client' do
      client_attributes = attributes_for(:client)

      post api_v1_clients_path, { client: client_attributes }, headers

      expect(response).to have_http_status(201)
      expect(response.content_type).to eq('application/json')

      expect(json[:client_type]).to eq(client_attributes[:client_type])
      expect(json[:gln]).to eq(client_attributes[:gln])
      expect(json[:full_name]).to eq(client_attributes[:full_name])
      expect(json[:short_name]).to eq(client_attributes[:short_name])
    end
  end
end
