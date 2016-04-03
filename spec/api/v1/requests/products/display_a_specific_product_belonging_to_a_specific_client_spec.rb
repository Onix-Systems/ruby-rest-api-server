require 'rails_helper'

RSpec.describe 'API Display Product Belonging To A Specific Client', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  before do
    @client = create(:client)
    @product = @client.products.create(attributes_for(:product))
  end

  context 'GET /api/v1/clients/:client_id/products/:id' do
    it 'displays a specific product belonging to a specific client' do
      get api_v1_client_product_path(client_id: @client.id, id: @product.id), {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json[:gtin]).to eq(@product.gtin)
      expect(json[:bar_code_type]).to eq(@product.bar_code_type)
      expect(json[:unit_descriptor]).to eq(@product.unit_descriptor)
      expect(json[:internal_supplier_code]).to eq(@product.internal_supplier_code)
      expect(json[:brand_name]).to eq(@product.brand_name)
      expect(json[:description_short]).to eq(@product.description_short)
    end
  end
end
