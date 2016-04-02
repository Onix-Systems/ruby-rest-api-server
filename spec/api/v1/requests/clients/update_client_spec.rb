require 'rails_helper'

RSpec.describe 'API Update Client', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  let(:client_attributes) { attributes_for(:client) }

  context 'PUT /api/v1/clients/:id' do
    it 'updates a specific client' do
      @client = create(:client)

      put api_v1_client_path(id: @client.id), { client: client_attributes }, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json[:client_type]).to eq(client_attributes[:client_type])
      expect(json[:gln]).to eq(client_attributes[:gln])
      expect(json[:full_name]).to eq(client_attributes[:full_name])
      expect(json[:short_name]).to eq(client_attributes[:short_name])
    end

    it 'updates a specific client with nested products' do
      @client = create(:client) do |c|
        c.products.create(attributes_for(:product))
      end

      product_attributes = attributes_for(:product)

      client_attributes[:client_products_attributes] = [{ id: @client.client_products.at(0).id, product_attributes: product_attributes }]

      put api_v1_client_path(id: @client.id), { client: client_attributes }, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json[:client_type]).to eq(client_attributes[:client_type])
      expect(json[:gln]).to eq(client_attributes[:gln])
      expect(json[:full_name]).to eq(client_attributes[:full_name])
      expect(json[:short_name]).to eq(client_attributes[:short_name])

      expect(json[:products][0][:gtin]).to eq(product_attributes[:gtin])
      expect(json[:products][0][:bar_code_type]).to eq(product_attributes[:bar_code_type])
      expect(json[:products][0][:unit_descriptor]).to eq(product_attributes[:unit_descriptor])
      expect(json[:products][0][:internal_supplier_code]).to eq(product_attributes[:internal_supplier_code])
      expect(json[:products][0][:brand_name]).to eq(product_attributes[:brand_name])
      expect(json[:products][0][:description_short]).to eq(product_attributes[:description_short])
    end
  end
end
