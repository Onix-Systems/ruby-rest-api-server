require 'rails_helper'
require 'faker'

RSpec.describe 'Auth', type: :request do
  describe 'POST /auth' do
    it 'creates new user via email registration' do
      headers = { 'ACCEPT' => 'application/json' }
      email = Faker::Internet.email
      password = Faker::Internet.password

      post api_v1_user_registration_path, {
        email: email,
        password: password,
        password_confirmation: password,
        confirm_success_url: ''
      }, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      json = JSON.parse(response.body, symbolize_names: true)

      expect(json[:data][:uid]).to eq(email)
      expect(json[:data][:email]).to eq(email)
    end
  end
end
