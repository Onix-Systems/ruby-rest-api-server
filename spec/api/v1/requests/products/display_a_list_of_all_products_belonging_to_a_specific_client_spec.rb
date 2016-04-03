require 'rails_helper'

RSpec.describe 'API Display A List Of Products Belonging To A Specific Client', type: :request do
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

  context 'GET /api/v1/clients/:client_id/products' do
    it 'displays a list of all products belonging to a specific client' do
      get api_v1_client_products_path(client_id: @client.id), {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json.length).to eq(1)

      expect(json[0][:gtin]).to eq(@product.gtin)
      expect(json[0][:bar_code_type]).to eq(@product.bar_code_type)
      expect(json[0][:unit_descriptor]).to eq(@product.unit_descriptor)
      expect(json[0][:internal_supplier_code]).to eq(@product.internal_supplier_code)
      expect(json[0][:brand_name]).to eq(@product.brand_name)
      expect(json[0][:description_short]).to eq(@product.description_short)
    end
  end
end
