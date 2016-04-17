require 'rails_helper'

RSpec.describe 'API Display A List Of Products Belonging To A Specific Client', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  before(:each) do
    @client_with_products = create(:client_with_products, products_count: 15)

    @products_hashes = @client_with_products.products.to_a.sort_by!(&:id).map do |product|
      product.as_json(only: [:id, :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short]).symbolize_keys
    end
  end

  context 'GET /api/v1/clients/:client_id/products' do
    it 'displays a list of all products belonging to a specific client' do
      get api_v1_client_products_path(client_id: @client_with_products.id), {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      sliced_response = json.map do |product|
        product.as_json(only: [:id, :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short]).symbolize_keys
      end

      expect(json.length).to eq(15)
      expect(sliced_response).to eq(@products_hashes)
    end
  end

  context 'GET /api/v1/clients/:client_id/products/page/:page' do
    it 'displays a list of all products belonging to a specific client with default per_page param' do
      get api_v1_client_products_path(client_id: @client_with_products.id, page: 1), {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      sliced_response = json.map do |product|
        product.as_json(only: [:id, :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short]).symbolize_keys
      end

      expect(json.length).to eq(10)
      expect(sliced_response).to eq(@products_hashes.slice!(0, 10))
    end
  end

  context 'GET /api/v1/clients/:client_id/products/page/:page/per_page/:per_page' do
    it 'displays a list of all products belonging to a specific client with specified per_page items number' do
      get api_v1_client_products_path(client_id: @client_with_products.id, page: 1, per_page: 5), {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      sliced_response = json.map do |product|
        product.as_json(only: [:id, :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short]).symbolize_keys
      end

      expect(json.length).to eq(5)
      expect(sliced_response).to eq(@products_hashes.slice!(0, 5))
    end
  end
end
