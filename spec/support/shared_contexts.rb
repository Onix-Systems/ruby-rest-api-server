# before(:each) provide Warden test helpers
# after(:each) reset Warden in test mode in the cleanup phase
RSpec.shared_context 'configure Warden test helpers' do
  before(:each) do
    Warden.test_mode!
  end

  after(:each) do
    Warden.test_reset!
  end
end

RSpec.shared_context 'sign in user and create new auth token' do
  before(:each) do
    sign_in user
    auth_headers = user.create_new_auth_token
    headers.merge!(auth_headers)
  end
end
