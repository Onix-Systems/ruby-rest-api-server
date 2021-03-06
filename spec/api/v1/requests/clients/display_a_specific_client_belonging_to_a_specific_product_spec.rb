require 'rails_helper'

RSpec.describe 'API Display Client Belonging To A Specific Product', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  before do
    @product = create(:product)
    @client = @product.clients.create(attributes_for(:client))
  end

  context 'GET /api/v1/products/:product_id/clients/:id' do
    it 'displays a specific client belonging to a specific product' do
      get api_v1_product_client_path(product_id: @product.id, id: @client.id), {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json[:client_type]).to eq(@client.client_type)
      expect(json[:gln]).to eq(@client.gln)
      expect(json[:full_name]).to eq(@client.full_name)
      expect(json[:short_name]).to eq(@client.short_name)
    end
  end
end
