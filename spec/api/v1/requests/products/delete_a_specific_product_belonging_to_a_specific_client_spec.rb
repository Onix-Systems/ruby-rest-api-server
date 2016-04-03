require 'rails_helper'

RSpec.describe 'API Delete Product Belonging To A Specific Client', type: :request do
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

  context 'DELETE /api/v1/clients/:client_id/products/:id' do
    it 'deletes a specific product belonging to a specific client' do
      delete api_v1_client_product_path(client_id: @client.id, id: @product.id), {}, headers

      expect(response).to have_http_status(204)
    end
  end
end
