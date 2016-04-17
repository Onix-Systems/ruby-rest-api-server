require 'rails_helper'

RSpec.describe 'API Display A List Of Products', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  before(:each) do
    @products = FactoryGirl.create_list(:product, 15)

    @products_hashes = @products.sort_by!(&:id).map do |product|
      product.as_json(only: [:id, :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short]).symbolize_keys
    end
  end

  context 'GET /api/v1/products' do
    it 'displays a list of all products' do
      get api_v1_products_path, {}, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      sliced_response = json.map do |product|
        product.slice(:id, :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short)
      end

      expect(json.length).to eq(15)
      expect(sliced_response).to eq(@products_hashes)
    end

    context 'GET /api/v1/products/page/:page' do
      it 'displays a paginatable list of products with default per_page param' do
        get api_v1_products_path(page: 1), {}, headers

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')

        sliced_response = json.map do |product|
          product.slice(:id, :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short)
        end

        expect(json.length).to eq(10)
        expect(sliced_response).to eq(@products_hashes.slice!(0, 10))
      end
    end

    context 'GET /api/v1/products/page/:page/per_page/:per_page' do
      it 'displays a paginatable list of products with specified per_page items number' do
        get api_v1_products_path(page: 1, per_page: 5), {}, headers

        expect(response).to have_http_status(200)
        expect(response.content_type).to eq('application/json')

        sliced_response = json.map do |product|
          product.slice(:id, :gtin, :bar_code_type, :unit_descriptor, :internal_supplier_code, :brand_name, :description_short)
        end

        expect(json.length).to eq(5)
        expect(sliced_response).to eq(@products_hashes.slice!(0, 5))
      end
    end
  end
end
