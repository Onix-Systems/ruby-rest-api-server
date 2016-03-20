require 'rails_helper'

RSpec.describe 'API Email Authentication', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  context 'POST /api/v1/auth/sign_in' do
    it 'return a JSON representation of the User model on successful login
        along with the access-token and client in the header of the response' do
      post api_v1_user_session_path, {
        email: email,
        password: password
      }, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(response['access-token']).to be_present
      expect(response['token-type']).to be_present
      expect(response['client']).to be_present
      expect(response['expiry']).to be_present
      expect(response['uid']).to be_present

      expect(json[:data][:uid]).to eq(email)
      expect(json[:data][:email]).to eq(email)
    end
  end

  context 'POST /api/v1/auth/sign_in' do
    it "doesn't login user with the wrong credentials" do
      wrong_email = Faker::Internet.email
      wrong_password = Faker::Internet.password

      post api_v1_user_session_path, {
        email: wrong_email,
        password: wrong_password
      }, headers

      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(401)
      expect(response.content_type).to eq('application/json')
    end
  end
end
