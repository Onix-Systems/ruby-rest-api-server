require 'rails_helper'

RSpec.describe 'API Display A List Of Products', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  before do
    create(:product)
  end

  context 'GET /api/v1/products' do
    it 'displays a list of all products' do
      product_attributes = attributes_for(:product)

      get api_v1_products_path, {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json.length).to eq(1)
      expect(json[0][:gtin]).to eq(product_attributes[:gtin])
      expect(json[0][:bar_code_type]).to eq(product_attributes[:bar_code_type])
      expect(json[0][:unit_descriptor]).to eq(product_attributes[:unit_descriptor])
      expect(json[0][:internal_supplier_code]).to eq(product_attributes[:internal_supplier_code])
      expect(json[0][:brand_name]).to eq(product_attributes[:brand_name])
      expect(json[0][:description_short]).to eq(product_attributes[:description_short])
    end
  end
end