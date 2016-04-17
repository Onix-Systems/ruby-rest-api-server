require 'rails_helper'

RSpec.describe 'API Display A List Of Clients', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  before(:each) do
    @clients = FactoryGirl.create_list(:client, 15)

    @clients_hashes = @clients.sort_by!(&:id).map do |client|
      client.as_json(only: [:id, :client_type, :gln, :full_name, :short_name]).symbolize_keys
    end
  end

  context 'GET /api/v1/clients' do
    it 'displays a list of all clients' do
      get api_v1_clients_path, {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      sliced_response = json.map do |client|
        client.slice(:id, :client_type, :gln, :full_name, :short_name)
      end

      expect(json.length).to eq(15)
      expect(sliced_response).to eq(@clients_hashes)
    end
  end

  context 'GET /api/v1/clients/page/:page' do
    it 'displays a paginatable list of clients with default per_page param' do
      get api_v1_clients_path(page: 1), {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      sliced_response = json.map do |client|
        client.slice(:id, :client_type, :gln, :full_name, :short_name)
      end

      expect(json.length).to eq(10)
      expect(sliced_response).to eq(@clients_hashes.slice!(0, 10))
    end
  end

  context 'GET /api/v1/clients/page/:page/per_page/:per_page' do
    it 'displays a paginatable list of clients with specified per_page items number' do
      get api_v1_clients_path(page: 1, per_page: 5), {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      sliced_response = json.map do |client|
        client.slice(:id, :client_type, :gln, :full_name, :short_name)
      end

      expect(json.length).to eq(5)
      expect(sliced_response).to eq(@clients_hashes.slice!(0, 5))
    end
  end
end
