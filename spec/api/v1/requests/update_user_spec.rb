require 'rails_helper'

RSpec.describe 'API Account Updates', type: :request do
  let!(:email) { Faker::Internet.email }
  let!(:password) { Faker::Internet.password }

  let!(:user) { create(:user, email: email, password: password) }
  let!(:headers) { { 'ACCEPT' => 'application/json' } }

  include_context 'configure Warden test helpers'
  include_context 'sign in user and create new auth token'

  context 'PUT /api/v1/auth' do
    it "updates an existing user's account settings" do
      new_email = Faker::Internet.email
      new_password = Faker::Internet.password

      put api_v1_user_registration_path, {
        email: new_email,
        password: new_password,
        password_confirmation: new_password,
        current_password: password
      }, headers

      expect(response).to have_http_status(200)
      expect(response.content_type).to eq('application/json')

      expect(json[:data][:uid]).to eq(new_email)
      expect(json[:data][:email]).to eq(new_email)
    end

    it "doesn't update an existing user's account settings without current_password" do
      new_email = Faker::Internet.email
      new_password = Faker::Internet.password

      put api_v1_user_registration_path, {
        email: new_email,
        password: new_password,
        password_confirmation: new_password
      }, headers

      expect(response).not_to have_http_status(200)
      expect(response).to have_http_status(403)
      expect(response.content_type).to eq('application/json')
    end
  end
end
