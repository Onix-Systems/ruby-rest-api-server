Devise.setup do |config|
  # The e-mail address that mail will appear to be sent from
  config.mailer_sender = ENV['DEVISE_MAILER_SENDER']

  # Tells devise to not use ActionDispatch::Flash
  # middleware b/c rails-api does not include it.
  config.navigational_formats = [:json]

  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth, :token_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..128
  config.reset_password_within = 6.hours
  config.sign_out_via = :delete
  config.secret_key = ENV['SECRET_KEY_BASE']
end
