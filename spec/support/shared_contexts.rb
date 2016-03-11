RSpec.shared_context 'Provide Warden test helpers' do
  before(:each) do
    Warden.test_mode!
  end
end

RSpec.shared_context 'Reset Warden in test mode in the cleanup phase' do
  after(:each) do
    Warden.test_reset!
  end
end
