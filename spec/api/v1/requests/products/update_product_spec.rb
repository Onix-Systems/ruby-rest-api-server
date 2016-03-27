require 'rails_helper'

RSpec.describe 'API Update Product', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  let(:product_attributes) do
    {
      gtin: Random.rand(9_000_000_000_000),
      bar_code_type: Faker::Lorem.characters(10),
      unit_descriptor: Faker::Lorem.characters(10),
      internal_supplier_code: Faker::Lorem.characters(10),
      brand_name: Faker::Commerce.product_name,
      description_short: Faker::Lorem.sentence
    }
  end

  context 'PUT /api/v1/products/:id' do
    it 'updates a specific product' do
      product = create(:product)

      put api_v1_product_path(id: product.id), { product: product_attributes }, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json[:gtin]).to eq(product_attributes[:gtin])
      expect(json[:bar_code_type]).to eq(product_attributes[:bar_code_type])
      expect(json[:unit_descriptor]).to eq(product_attributes[:unit_descriptor])
      expect(json[:internal_supplier_code]).to eq(product_attributes[:internal_supplier_code])
      expect(json[:brand_name]).to eq(product_attributes[:brand_name])
      expect(json[:description_short]).to eq(product_attributes[:description_short])
    end

    it 'updates a specific product with nested clients' do
      product = create(:product) do |p|
        p.clients.create(attributes_for(:client))
      end

      client_attributes = {
        client_type: Random.rand(1..3),
        gln: Random.rand(9_000_000_000_000),
        short_name: Faker::Company.name,
        full_name: Faker::Company.suffix + ' ' + Faker::Company.name
      }

      product_attributes[:client_products_attributes] = [{ id: product.client_products.at(0).id, client_attributes: client_attributes }]

      put api_v1_product_path(id: product.id), { product: product_attributes }, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json[:gtin]).to eq(product_attributes[:gtin])
      expect(json[:bar_code_type]).to eq(product_attributes[:bar_code_type])
      expect(json[:unit_descriptor]).to eq(product_attributes[:unit_descriptor])
      expect(json[:internal_supplier_code]).to eq(product_attributes[:internal_supplier_code])
      expect(json[:brand_name]).to eq(product_attributes[:brand_name])
      expect(json[:description_short]).to eq(product_attributes[:description_short])

      expect(json[:clients][0][:client_type]).to eq(client_attributes[:client_type])
      expect(json[:clients][0][:gln]).to eq(client_attributes[:gln])
      expect(json[:clients][0][:full_name]).to eq(client_attributes[:full_name])
      expect(json[:clients][0][:short_name]).to eq(client_attributes[:short_name])
    end
  end
end
