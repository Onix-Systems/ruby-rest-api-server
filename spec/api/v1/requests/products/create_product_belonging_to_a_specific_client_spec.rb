require 'rails_helper'

RSpec.describe 'API Create Product Belonging To A Specific Client', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  before do
    @client = create(:client)
  end

  context 'POST /api/v1/clients/:client_id/products' do
    it 'creates new product belonging to a specific client' do
      product_attributes = attributes_for(:product)

      post api_v1_client_products_path(client_id: @client.id), { product: product_attributes }, headers

      expect(response).to have_http_status(201)
      expect(response.content_type).to eq('application/json')

      expect(json[:gtin]).to eq(product_attributes[:gtin])
      expect(json[:bar_code_type]).to eq(product_attributes[:bar_code_type])
      expect(json[:unit_descriptor]).to eq(product_attributes[:unit_descriptor])
      expect(json[:internal_supplier_code]).to eq(product_attributes[:internal_supplier_code])
      expect(json[:brand_name]).to eq(product_attributes[:brand_name])
      expect(json[:description_short]).to eq(product_attributes[:description_short])
    end

    it 'creates new product belonging to a specific client with nested clients' do
      client_attributes = attributes_for(:client)
      product_attributes = attributes_for(:product).merge!(
        client_products_attributes: [{ client_attributes: client_attributes }]
      )

      post api_v1_client_products_path(client_id: @client.id), { product: product_attributes }, headers

      expect(response).to have_http_status(201)
      expect(response.content_type).to eq('application/json')

      expect(json[:gtin]).to eq(product_attributes[:gtin])
      expect(json[:bar_code_type]).to eq(product_attributes[:bar_code_type])
      expect(json[:unit_descriptor]).to eq(product_attributes[:unit_descriptor])
      expect(json[:internal_supplier_code]).to eq(product_attributes[:internal_supplier_code])
      expect(json[:brand_name]).to eq(product_attributes[:brand_name])
      expect(json[:description_short]).to eq(product_attributes[:description_short])

      expect(json[:clients].length).to eq(1)

      expect(json[:clients][0][:client_type]).to eq(client_attributes[:client_type])
      expect(json[:clients][0][:gln]).to eq(client_attributes[:gln])
      expect(json[:clients][0][:full_name]).to eq(client_attributes[:full_name])
      expect(json[:clients][0][:short_name]).to eq(client_attributes[:short_name])
    end
  end
end
