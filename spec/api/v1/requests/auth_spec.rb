require 'rails_helper'

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

      expect(json[:data][:uid]).to eq(email)
      expect(json[:data][:email]).to eq(email)
    end
  end
end
