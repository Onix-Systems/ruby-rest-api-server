require 'rails_helper'

RSpec.describe 'API Display Product', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  before do
    @product = create(:product)
  end

  context 'GET /api/v1/products/:id' do
    it 'displays a specific product' do
      product_attributes = attributes_for(:product)

      get api_v1_product_path(id: @product.id), {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json[:gtin]).to eq(product_attributes[:gtin])
      expect(json[:bar_code_type]).to eq(product_attributes[:bar_code_type])
      expect(json[:unit_descriptor]).to eq(product_attributes[:unit_descriptor])
      expect(json[:internal_supplier_code]).to eq(product_attributes[:internal_supplier_code])
      expect(json[:brand_name]).to eq(product_attributes[:brand_name])
      expect(json[:description_short]).to eq(product_attributes[:description_short])
    end
  end
end
