require 'rails_helper'

RSpec.describe 'API Email Registration', type: :request do
  let!(:headers) { { 'ACCEPT' => 'application/json' } }
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  context 'POST /auth' do
    it 'creates new user via email registration' do
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
